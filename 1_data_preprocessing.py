#!/usr/bin/env python3

import cv2
import os
from tqdm import tqdm

# Folder containing JPG images
image_folder = 'data'
output_video = 'input.mp4'

max_width = 1600

# Get all JPG files in the folder and sort them
images = [img for img in os.listdir(image_folder) if img.endswith(".jpg")]
images.sort()  # ensures they are in order

# Read the first image to get the size
frame = cv2.imread(os.path.join(image_folder, images[0]))
height, width, layers = frame.shape

# Downscale first frame if needed
if width > max_width:
    scale = max_width / width
    width = max_width
    height = int(height * scale)
    frame = cv2.resize(frame, (width, height), interpolation=cv2.INTER_AREA)

size = (width, height)

# Create VideoWriter object
out = cv2.VideoWriter(output_video, cv2.VideoWriter_fourcc(*'mp4v'), 10, size)

for image in tqdm(images, desc="Creating video"):
    img_path = os.path.join(image_folder, image)
    frame = cv2.imread(img_path)

    # Resize if wider than max_width
    h, w, _ = frame.shape
    if w > max_width:
        scale = max_width / w
        new_h = int(h * scale)
        frame = cv2.resize(frame, (max_width, new_h), interpolation=cv2.INTER_AREA)

    # Ensure exact size (important for VideoWriter)
    if frame.shape[1] != width or frame.shape[0] != height:
        frame = cv2.resize(frame, size, interpolation=cv2.INTER_AREA)

    out.write(frame)

out.release()
print(f"Video saved as {output_video}")
