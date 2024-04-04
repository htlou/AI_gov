if [ -z "${BASH_VERSION}" ]; then
	echo "Please use bash to run this script." >&2
	exit 1
fi

set -x

SCRIPT_DIR="$(cd "$(dirname "$0")" &>/dev/null && pwd)"
ROOT_DIR="$(dirname "${SCRIPT_DIR}")"
SCRIPT_NAME=$(basename "$0")
SCRIPT_NAME_WITHOUT_EXTENSION="${SCRIPT_NAME%.sh}"
export PYTHONPATH="${ROOT_DIR}${PYTHONPATH:+:${PYTHONPATH}}"

# model_names=("gpt4" "llama2-7b-chat" "alpaca-7b"  "gpt3.5"  "llama2-13b-chat" "llama2-70b-chat" "vicuna-7b" "vicuna-13b-v1.5" "vicuna-33b-v1.3" "harmfulQA-mini-Alpaca-7B" "harmfulQA-mini-gpt4" "harmfulQA-mini-vicuna-7B" "harmfulQA-mini-llama2-70B-chat" "toxicity-minialpaca-7B" "toxicity-minigpt4" "toxicity-minillama2-70B-chat" "toxicity-minivicuna-7B" "claude")
# folder_names=("gpt4/" "llama2-7B-chat/" "alpaca-7B/"  "gpt3.5-turbo-1106/" "llama2-13B-chat/" "llama2-70B-chat/" "vicuna-7B/" "vicuna-13B-v1.5/" "vicuna-33B-v1.3/" "harmfulQA-mini-alpaca-7B/" "harmfulQA-mini-gpt4/" "harmfulQA-mini-vicuna-7B/" "harmfulQA-mini-llama2-70B-chat/" "toxicity-minialpaca-7B/" "toxicity-minigpt4/" "toxicity-minillama2-70B-chat/" "toxicity-minivicuna-7B/" "claude2/" "beaver/")

# folder_names=("beaver/" "claude2/" "harmfulQA/beaver/" "harmfulQA/claude2/" "harmfulQA/gpt4/" "llama2-70B-chat/" "llama2-7B-chat/" "llama2-13B-chat/" "harmfulQA/llama2-70B-chat/" "harmfulQA/llama2-7B-chat/" "harmfulQA/llama2-13B-chat/")

folder_names=("gpt4/" "llama2-7B-chat/" "alpaca-7B/"  "gpt3.5-turbo-1106/" "llama2-13B-chat/" "llama2-70B-chat/" "vicuna-7B/" "vicuna-13B-v1.5/" "vicuna-33B-v1.3/" "claude2/" "beaver/" "gpt3.5-turbo-1106/")

export LOGLEVEL="${LOGLEVEL:-WARNING}"
INPUT_PATH=""
OUTPUT_PATH=""
OUTPUT_FOLDER=""
OUTPUT_NAME=""
MODEL=""
PLATFORM="openai"

while [[ "$#" -gt 0 ]]; do
	arg="$1"
	shift
	case "${arg}" in
		--input-file)
			INPUT_PATH=$1
			shift
			;;
		--folder-name)
			folder_names=("")
			shift
			;;
		*)
			echo "Unknown parameter passed: '${arg}'" >&2
			exit 1
			;;
	esac
done


MASTER_PORT_START=10000
MASTER_PORT_END=65535
MASTER_PORT="$(
	comm -23 \
		<(seq "${MASTER_PORT_START}" "${MASTER_PORT_END}" | sort) \
		<(ss -Htan | awk '{ print $4 }' | awk -F ':' '{ print $NF }' | sort -u) |
		shuf | head -n 1
)"

# ray start --head --port=${MASTER_PORT}
# If master port was used , use a number you like instead, like 6379
# ray stop

python3 main.py --debug \
    --openai-api-key-file ${SCRIPT_DIR}/config/openai_api_keys.txt \
    --input-file ${SCRIPT_DIR}/${INPUT_PATH} \
    --cache-dir ${SCRIPT_DIR}/.cache/\
	--num-workers 50 \
	--type "tmp" \
    --shuffle 