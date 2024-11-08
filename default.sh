#!/bin/bash
# This file will be run by init.sh
# Namespace functions with provisioning_

# https://raw.githubusercontent.com/ai-dock/fooocus/main/config/provisioning/default.sh

# Default for Fooocus is do nothing!

### Edit the following arrays to suit your workflow - values must be quoted and separated by newlines or spaces.

DISK_GB_REQUIRED=30

PIP_PACKAGES=(

)

CHECKPOINT_MODELS=(
    #"https://civitai.com/api/download/models/918032?type=Model&format=SafeTensor&size=full&fp=fp16" # AniVerse Pony : https://civitai.com/models/594253/aniverse-pony-xl
    #"https://civitai.com/api/download/models/646313?type=Model&format=SafeTensor&size=pruned&fp=fp16" #AniVerse : https://civitai.com/api/download/models/646313?type=Model&format=SafeTensor&size=pruned&fp=fp16
    "https://huggingface.co/LyliaEngine/Pony_Diffusion_V6_XL/resolve/main/ponyDiffusionV6XL_v6StartWithThisOne.safetensors" # Pony Diffusion : https://civitai.com/models/257749/pony-diffusion-v6-xl?modelVersionId=290640
    "https://huggingface.co/cagliostrolab/animagine-xl-3.1/resolve/main/animagine-xl-3.1.safetensors" # Animagine : https://civitai.com/models/260267/animagine-xl-v31?modelVersionId=403131
    #"https://civitai.com/api/download/models/531417?type=Model&format=SafeTensor&size=pruned&fp=fp16" # DucHaiten : https://civitai.com/models/376450/duchaiten-pony-xl-no-score?modelVersionId=531417
    #"https://civitai.com/api/download/models/324524?type=Model&format=SafeTensor&size=pruned&fp=fp16" #AutismMix : https://civitai.com/models/288584/autismmix-sdxl?modelVersionId=324524
    #"https://civitai.com/api/download/models/828380?type=Model&format=SafeTensor&size=pruned&fp=fp16" #Perfect Pony : https://civitai.com/models/439889/prefect-pony-xl?modelVersionId=828380
)

LORA_MODELS=(
    "https://huggingface.co/KirtiKousik/detail-tweaker-XL/resolve/main/add-detail-xl.safetensors" #Detaile Tweaker : https://civitai.com/models/122359/detail-tweaker-xl?modelVersionId=135867
    "https://huggingface.co/Danilin3300/ExpressiveH_Hentai_LoRa_Style/resolve/main/Expressive_H-000001.safetensors" #Expressive Hentai : https://civitai.com/models/341353/expressiveh-hentai-lora-style?modelVersionId=382152
    "https://huggingface.co/imagepipeline/Hand-Detail-Lora-XL-v2.0/resolve/main/99d314e4-5e34-480a-a330-bf60b3a9d299.safetensors" #Hand Details : https://civitai.com/models/260852/hand-detail-xl-lora?modelVersionId=294259
    "https://huggingface.co/rorito/concept-perfect-eyes/resolve/main/PerfectEyesXL.safetensors" #Perfect Eyes : https://civitai.com/models/119399/concept-perfect-eyes?modelVersionId=129711
    "https://huggingface.co/MarkBW/realcum-xl/resolve/main/realcumSDXLv4.5.safetensors" #Real Cum : https://civitai.com/models/326320/real-cum-sdxl?modelVersionId=498843
    #"https://civitai.com/api/download/models/856243?type=Model&format=SafeTensor" # Adjusting clothes : https://civitai.com/models/93524/adjusting-clothes?modelVersionId=856243
    #"https://civitai.com/api/download/models/619176?type=Model&format=SafeTensor" #Pillow : https://civitai.com/models/151195/pillow-humping?modelVersionId=619176
    #"https://civitai.com/api/download/models/721234?type=Model&format=SafeTensor" #Doggy : https://civitai.com/models/644741/doggystyle-dp-for-gurilamash-v2?modelVersionId=721234
)


### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    source /opt/ai-dock/etc/environment.sh
    source /opt/ai-dock/bin/venv-set.sh fooocus

    DISK_GB_AVAILABLE=$(($(df --output=avail -m "${WORKSPACE}" | tail -n1) / 1000))
    DISK_GB_USED=$(($(df --output=used -m "${WORKSPACE}" | tail -n1) / 1000))
    DISK_GB_ALLOCATED=$(($DISK_GB_AVAILABLE + $DISK_GB_USED))

    provisioning_print_header
    provisioning_get_pip_packages
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/ckpt" \
        "${CHECKPOINT_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/lora" \
        "${LORA_MODELS[@]}"
    
    provisioning_print_end
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
        "$FOOOCUS_VENV_PIP" install --no-cache-dir ${PIP_PACKAGES[@]}
    fi
}

function provisioning_get_models() {
    if [[ -z $2 ]]; then return 1; fi
    dir="$1"
    mkdir -p "$dir"
    shift
    if [[ $DISK_GB_ALLOCATED -ge $DISK_GB_REQUIRED ]]; then
        arr=("$@")
    else
        printf "WARNING: Low disk space allocation - Only the first model will be downloaded!\n"
        arr=("$1")
    fi
    
    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    for url in "${arr[@]}"; do
        printf "Downloading: %s\n" "${url}"
        provisioning_download "${url}" "${dir}"
        printf "\n"
    done
}


function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
    if [[ $DISK_GB_ALLOCATED -lt $DISK_GB_REQUIRED ]]; then
        printf "WARNING: Your allocated disk size (%sGB) is below the recommended %sGB - Some models will not be downloaded\n" "$DISK_GB_ALLOCATED" "$DISK_GB_REQUIRED"
    fi
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Fooocus will start now\n\n"
}

# Download from $1 URL to $2 file path
function provisioning_download() {
    if [[ -n $HF_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?huggingface\.co(/|$|\?) ]]; then
        auth_token="$HF_TOKEN"
    elif 
        [[ -n $CIVITAI_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?civitai\.com(/|$|\?) ]]; then
        auth_token="$CIVITAI_TOKEN"
    fi
    if [[ -n $auth_token ]];then
        wget --header="Authorization: Bearer $auth_token" -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    else
        wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    fi
}

provisioning_start
