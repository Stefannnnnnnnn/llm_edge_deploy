# 0. Init a uv environment for evaluation
# NOTE: This environment could also be used for inference locally
uv venv .venv-eval --python 3.12 --seed
source ...

# 1. Install vllm
git clone https://github.com/vllm-project/vllm.git
cd vllm
VLLM_USE_PRECOMPILED=1 uv pip install -e .

# 2. Install lm_evaluation_harness
uv pip install git+https://github.com/EleutherAI/lm-evaluation-harness.git@206b7722158f58c35b7ffcd53b035fdbdda5126d#egg=lm-eval[api]

# 3. Run lm_eval mmlu benchmark with vllm backend
# 3.1 Quantized model
lm_eval --model vllm \ 
--model_args pretrained=quantized_model_path,dtype=auto,quantization=compressed-tensors,gpu_memory_utilization=0.8 \
--tasks mmlu  --batch_size auto --num_fewshot 5  --limit 100
# 3.2 Original Model
lm_eval --model vllm \ 
--model_args pretrained=model_path,dtype=auto,gpu_memory_utilization=0.8 \
--tasks mmlu  --batch_size auto --num_fewshot 5  --limit 100
# Note: If CUDA OOM, try to reduce gpu_memory_utilization or set batch_size smaller.
# Note: If run into errors related "model_type" in hf transformers lib, try to downgrade it to 4.57.1
# Reference Issue: https://github.com/huggingface/transformers/pull/42389

