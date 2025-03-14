#!/bin/bash
# This file will be run by init.sh
# Namespace functions with provisioning_

# https://raw.githubusercontent.com/ai-dock/fooocus/main/config/provisioning/default.sh

# Default for Fooocus is do nothing!

### Edit the following arrays to suit your workflow - values must be quoted and separated by newlines or spaces.

DISK_GB_REQUIRED=60

PIP_PACKAGES=(

)

CHECKPOINT_MODELS=(
    #Anime
    #"https://civitai.com/api/download/models/918032?type=Model&format=SafeTensor&size=full&fp=fp16" # AniVerse Pony : https://civitai.com/models/594253/aniverse-pony-xl
    #"https://civitai.com/api/download/models/646313?type=Model&format=SafeTensor&size=pruned&fp=fp16" #AniVerse : https://civitai.com/api/download/models/646313?type=Model&format=SafeTensor&size=pruned&fp=fp16
    "https://huggingface.co/LyliaEngine/Pony_Diffusion_V6_XL/resolve/main/ponyDiffusionV6XL_v6StartWithThisOne.safetensors" # Pony Diffusion : https://civitai.com/models/257749/pony-diffusion-v6-xl?modelVersionId=290640
    #"https://huggingface.co/cagliostrolab/animagine-xl-3.1/resolve/main/animagine-xl-3.1.safetensors" # Animagine : https://civitai.com/models/260267/animagine-xl-v31?modelVersionId=403131
    #"https://civitai.com/api/download/models/531417?type=Model&format=SafeTensor&size=pruned&fp=fp16" # DucHaiten : https://civitai.com/models/376450/duchaiten-pony-xl-no-score?modelVersionId=531417
    #"https://civitai.com/api/download/models/324524?type=Model&format=SafeTensor&size=pruned&fp=fp16" #AutismMix : https://civitai.com/models/288584/autismmix-sdxl?modelVersionId=324524
    #"https://civitai.com/api/download/models/828380?type=Model&format=SafeTensor&size=pruned&fp=fp16" #Perfect Pony : https://civitai.com/models/439889/prefect-pony-xl?modelVersionId=828380

    #Realistic
    "https://huggingface.co/cyberdelia/CyberRealisticPony/resolve/main/CyberRealisticPony_V7a.safetensors" #CyberReal Pony
    "https://huggingface.co/RunDiffusion/Juggernaut-XL-v9/resolve/main/Juggernaut-XL_v9_RunDiffusionPhoto_v2.safetensors" #Juggernaut XL
    "https://huggingface.co/SG161222/RealVisXL_V5.0/resolve/main/RealVisXL_V5.0_fp32.safetensors" #RealVis : https://civitai.com/models/139562/realvisxl-v50?modelVersionId=789646
    #"https://huggingface.co/yanex0/realism-engine-SDXL/resolve/main/realismEngineSDXL_v10.safetensors" #Realism Engine SDXL : https://civitai.com/models/152525/realism-engine-sdxl?modelVersionId=293240
    "https://huggingface.co/misri/epicrealismXL_v5Ultimate/resolve/main/epicrealismXL_v5Ultimate.safetensors" #EpicRealism : https://civitai.com/models/277058/epicrealism-xl?modelVersionId=646523
    #"https://huggingface.co/Lykon/dreamshaper-xl-1-0/resolve/main/unet/diffusion_pytorch_model.fp16.safetensors" #Dreamshaper
    #"https://huggingface.co/luisrguerra/rdxl-beta/resolve/main/pony-12-real-dream.safetensors" #Real Dream SDXL : https://civitai.com/models/153568?modelVersionId=832353
    #"https://huggingface.co/Justin-Choo/XXMix_9realisticSDXL/resolve/main/xxmix9realisticsdxl_testV20.safetensors" #XXMix_9realisticSDXL : https://civitai.com/models/124421/xxmix9realisticsdxl?modelVersionId=163192

    #Refiner
    #"https://huggingface.co/ferdyshampo/OnlyForNsfw118/resolve/main/onlyfornsfw118_v20.safetensors"
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
    "https://huggingface.co/DarkAngelH/Nudify_XL_Better_Bodies/resolve/main/nudify_xl_lite.safetensors" #Nudify XL: Better Bodies : https://civitai.com/models/9025/nudify-xl-better-bodies?modelVersionId=177674
    "https://huggingface.co/DarkAngelH/Innies_Better_vulva/resolve/main/innievag%20body.safetensors" #Better Vulva : https://civitai.com/models/10364/innies-better-vulva
    "https://huggingface.co/Artguy32/Styles-for-Pony-Diffusion-V6-XL/resolve/main/Concept%20Art%20Twilight%20Style%20SDXL_LoRA_Pony%20Diffusion%20V6%20XL.safetensors"
    "https://huggingface.co/Artguy32/Styles-for-Pony-Diffusion-V6-XL/resolve/main/Smooth%20Anime%20Style%20LoRA%20XL.safetensors"
    "https://huggingface.co/LarryAIDraw/nobrav1_SDXL/resolve/main/nobrav1_SDXL.safetensors"
    "https://huggingface.co/TheImposterImposters/betterfacesculturessdxl-better_faces_pony_strong/resolve/main/face_strong_sevenof9.safetensors"
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
