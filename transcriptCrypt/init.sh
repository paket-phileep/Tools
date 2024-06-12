# yt-dlp --flat-playlist -i --print-to-file url urls.txt "https://www.youtube.com/playlist?list=PLTZYG7bZ1u6puLWxUtqAjZkIB4dB_JFzk"

# # yt-dlp --skip-download --write-auto-subs --write-subs --sub-lang en --convert-subs srt --sub-format txt   --batch-file urls.txt 
# yt-dlp --skip-download --write-auto-subs --write-subs --sub-lang en --convert-subs srt --sub-format txt --batch-file urls.txt -o "./subtitles/%(title)s.%(ext)s"

source .venv/bin/activate

python3 main.py