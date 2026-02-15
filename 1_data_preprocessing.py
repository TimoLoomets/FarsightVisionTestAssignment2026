#!/usr/bin/env python3

import cv2
import os
from tqdm import tqdm

# Folder containing JPG images
image_folder = 'data'
output_video = 'input.mp4'

# Get all JPG files in the folder and sort them
images = [img for img in os.listdir(image_folder) if img.endswith(".jpg")]
images.sort()  # ensures they are in order

# Read the first image to get the size
frame = cv2.imread(os.path.join(image_folder, images[0]))
height, width, layers = frame.shape
size = (width, height)

# Create VideoWriter object
out = cv2.VideoWriter(output_video, cv2.VideoWriter_fourcc(*'mp4v'), 10, size)

for image in tqdm(images, desc="Creating video"):
    img_path = os.path.join(image_folder, image)
    frame = cv2.imread(img_path)
    out.write(frame)

out.release()
print(f"Video saved as {output_video}")
