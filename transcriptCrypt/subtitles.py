import os
import random
import re
from PyPDF2 import PdfWriter, PdfReader
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas


def remove_timestamps(srt_content):
    # Regular expression to match timestamps in SRT format
    timestamp_pattern = re.compile(r'\d+:\d+:\d+,\d+ --> \d+:\d+:\d+,\d+\n')
    # Replace timestamps with an empty string
    return re.sub(timestamp_pattern, '', srt_content)


def remove_incremental_numbers(srt_content):
    modified_content = ""
    last_num = None
    num_pattern = re.compile(r'\d+')
    nums = num_pattern.findall(srt_content)
    for num in nums:
        if last_num is None or int(num) > last_num:
            last_num = int(num)
    lines = srt_content.split('\n')
    for line in lines:
        if not num_pattern.search(line) or int(num_pattern.search(line).group()) == last_num:
            modified_content += line + '\n'
    return modified_content

def remove_duplicate_lines(srt_content):
    lines = srt_content.split('\n')
    seen_lines = set()
    unique_lines = []
    for line in lines:
        stripped_line = line.strip()
        if stripped_line and stripped_line not in seen_lines:
            seen_lines.add(stripped_line)
            unique_lines.append(stripped_line)
    modified_content = '\n'.join(unique_lines)
    return modified_content


def create_pdf_page(content, temp_name):
    # Create a canvas with letter size (8.5x11 inch)
  
    c = canvas.Canvas(temp_name, pagesize=letter)
    # Set the font and font size
    c.setFont("Helvetica", 12)
    # Split content into lines to fit within the screen
    lines = content.split('\n')
    y_coordinate = 750  # Initial y-coordinate
    for line in lines:
        # Set the content
        c.drawString(30, y_coordinate, line)
        # Move to the next line
        y_coordinate -= 15  # Adjust as needed based on line spacing
        # Check if the next line goes beyond the bottom margin
        if y_coordinate < 50:
            # Add a new page and reset the y-coordinate
            c.showPage()
            y_coordinate = 750  # Reset to top of the page

    # Save the canvas
    c.save()


def convert_srt_to_pdf(srt_files, output_pdf):
    writer = PdfWriter()

    for index, srt_file in enumerate(srt_files):
        srt_filename = os.path.splitext(os.path.basename(srt_file))[0]

        with open(srt_file, 'r', encoding='utf-8') as f:
            srt_content = f.read()
            # Remove timestamps
            srt_content = remove_timestamps(srt_content)
            # Remove numbers
            srt_content = remove_incremental_numbers(srt_content)
             # Remove duplicates
            srt_content = remove_duplicate_lines(srt_content)

            # Create PDF page from content
            create_pdf_page(srt_content, f"Transcript_{srt_filename}.pdf")
            # Add the page to the PDF writer
            with open(f"Transcript_{srt_filename}.pdf", 'rb') as temp_pdf:
                reader = PdfReader(temp_pdf)
                for page in reader.pages:
                    writer.add_page(page)

    # Write the PDF to the output file
    with open(output_pdf, 'wb') as f:
        writer.write(f)

if __name__ == "__main__":
    # Directory containing SRT files
    srt_directory = "./subtitles"
    # List all SRT files in the directory
    srt_files = [os.path.join(srt_directory, file) for file in os.listdir(srt_directory) if file.endswith(".srt")]
    # Output PDF file name
    output_pdf = "output.pdf"

    convert_srt_to_pdf(srt_files, output_pdf)
