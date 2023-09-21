#!/bin/false

# This file will be sourced in init.sh

# Function to download model files if they do not exist
download_model() {
    local file=$1
    local url=$2

    if [[ ! -f ${file} ]]; then
        wget -q --show-progress -e dotbytes="${3:-4M}" -O ${file} ${url}
    fi
}

## Directory and URL configurations
#searge_git="https://github.com/SeargeDP/SeargeSDXL"
#searge_dir="/opt/ComfyUI/custom_nodes/SeargeSDXL"

#
## Clone or pull SeargeSDXL repository
#if [[ ! -d $searge_dir ]]; then
#    git clone ${searge_git} $searge_dir
#else
#    cd $searge_dir && git pull
#fi

models_dir=/opt/ComfyUI/models
checkpoints_dir=${models_dir}/checkpoints
vae_dir=${models_dir}/vae
loras_dir=${models_dir}/loras
upscale_dir=${models_dir}/upscale_models


# Declare a single associative array with file paths as keys and URLs as values
declare -A model_map=(
# sdxl    ["${checkpoints_dir}/sd_xl_base_1.0.safetensors"]="https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"
# sdxl ref   ["${checkpoints_dir}/sd_xl_refiner_1.0.safetensors"]="https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors"
    ["${checkpoints_dir}/RealitiesEdgeXL.safetensors"]="https://civitai.com/api/download/models/142162"
    ["${checkpoints_dir}/DarkRevPikas.safetensors"]="https://civitai.com/api/download/models/105511"
    ["${vae_dir}/sdxl_vae.safetensors"]="https://huggingface.co/madebyollin/sdxl-vae-fp16-fix/resolve/main/sdxl_vae.safetensors"
    ["${vae_dir}/vae-ft-mse-840000-ema-pruned.safetensors"]="https://huggingface.co/stabilityai/sd-vae-ft-mse-original/blob/main/vae-ft-mse-840000-ema-pruned.safetensors"
    ["${vae_dir}/vae-ft-ema-560000-ema-pruned.safetensors"]="https://huggingface.co/stabilityai/sd-vae-ft-ema-original/resolve/main/vae-ft-ema-560000-ema-pruned.ckpt"
#    ["${loras_dir}/sd_xl_offset_example-lora_1.0.safetensors"]="https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_offset_example-lora_1.0.safetensors"
#    ["${upscale_dir}/4x_NMKD-Siax_200k.pth"]="https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x_NMKD-Siax_200k.pth"
    ["${upscale_dir}/4x-UltraSharp.pth"]="https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x-UltraSharp.pth"
)

# Download model files
for file in "${!model_map[@]}"; do
    url="${model_map[$file]}"
    download_model "$file" "$url"
done
