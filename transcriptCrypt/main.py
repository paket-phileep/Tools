import subprocess
import time
import sys

def print_loading(message, duration):
    for _ in range(duration):
        for frame in r'-\|/':
            sys.stdout.write('\r' + message + ' ' + frame)
            sys.stdout.flush()
            time.sleep(0.1)
    sys.stdout.write('\r' + message + '... done!\n')

def get_playlist_link():
    return input("Please enter the YouTube playlist link: ")

def extract_urls(playlist_link, output_file):
    command = f"yt-dlp --flat-playlist -i --print-to-file url {output_file} \"{playlist_link}\""
    subprocess.run(command, shell=True)

def download_subtitles(batch_file):
    command = f"yt-dlp --skip-download --write-auto-subs --write-subs --sub-lang en --convert-subs srt --sub-format txt --batch-file {batch_file} -o \"./subtitles/%(title)s.%(ext)s\""
    subprocess.run(command, shell=True)

def main():
    print("Activating virtual environment...")
    subprocess.run("source .venv/bin/activate", shell=True, executable="/bin/bash")
    
    playlist_link = get_playlist_link()
    output_file = "urls.txt"
    
    print("Extracting URLs from playlist...")
    print_loading("Extracting URLs", 5)
    extract_urls(playlist_link, output_file)
    
    print("Downloading from video transcript subtitles...")
    print_loading("Downloading subtitles", 10)
    download_subtitles(output_file)
    print("Process completed successfully!")
    subprocess.run("python3 subtitles.py", shell=True, executable="/bin/bash")
if __name__ == "__main__":
    main()
