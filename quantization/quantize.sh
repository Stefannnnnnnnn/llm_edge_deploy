# Install uv and source it
curl -LsSf https://astral.sh/uv/install.sh | sh

# Init uv environment
uv venv .venv-quant --python 3.12 --seed

# Activate uv environment
source .venv-quant/bin/activate

# Install llmcompressor
uv pip install llmcompressor

# Huggingface login with token
huggingface-cli login

# Set HF_HUB_CACHE & HF_HOME
# HF_HUB_CACHE is the directory for huggingface models and datasets
# HF_HOME is the directory for token and cache
export HF_HUB_CACHE=./hf_hub_cache
export HF_HOME=./hf_home

# Quantize model
python quantize.py