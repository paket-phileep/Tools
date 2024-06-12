# TranscriptCrypt

TranscriptCrypt is a powerful and easy-to-use command-line tool that fetches transcripts from YouTube playlists and saves them in an organized manner. With just a single command, you can retrieve transcripts for all videos in a playlist and have them neatly stored in the `output` folder.

## Features

- **Automated Transcript Retrieval**: Provide a YouTube playlist URL and TranscriptCrypt will handle the rest.
- **Batch Processing**: Fetch transcripts for all videos in a playlist with a single command.
- **Organized Output**: Transcripts are saved in the `output` folder, each named according to the corresponding video title.

## Prerequisites

Before you can use TranscriptCrypt, ensure you have the following installed:

- [Python 3](https://www.python.org/downloads/)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp) (YouTube downloader with transcript support)
- [pytube](https://pytube.io/) (Python library for YouTube)

## Installation

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/yourusername/TranscriptCrypt.git
    cd TranscriptCrypt
    ```

## Usage

1. Run the initialization script:

    ```bash
    sh init.sh
    ```

2. When prompted, enter the URL of the YouTube playlist you want to fetch transcripts for:

    ```plaintext
    Enter the URL of the YouTube playlist: <your_playlist_url>
    ```

3. The tool will process the playlist and save the transcripts in the `output` folder. Each transcript file will be named after the corresponding video title for easy reference.

## Important Notice

**Before Running the Code**
Make sure to empty your subtitles folder and url.txt file to avoid the risk of gathering all previous files every time you run the code.


## Example

```bash
$ bash init.sh
Enter the URL of the YouTube playlist: https://www.youtube.com/playlist?list=PLx65qkgCWNJIb21RANzTJ7t_XkMt5_9zI
Fetching transcripts...
Transcripts saved in the output folder.
```

## Output Structure

The `output` folder will contain the transcripts in the following format:

```
output/
│
├── Video Title 1.txt
├── Video Title 2.txt
├── Video Title 3.txt
└── ...
```

## Contributing

We welcome contributions to enhance TranscriptCrypt. To contribute, follow these steps:

1. Fork this repository.
2. Create a new branch: `git checkout -b feature/YourFeature`
3. Make your changes and commit them: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/YourFeature`
5. Submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any questions or feedback, feel free to reach out via [GitHub Issues](https://github.com/yourusername/TranscriptCrypt/issues).

---

Happy transcribing with TranscriptCrypt! 🚀
