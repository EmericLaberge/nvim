from PIL import Image

# Define the size of the image
width, height = 2560, 1664

# Create a new black image
image = Image.new('RGB', (width, height), color='black')

# Set the coordinates of the white pixel
white_pixel_coordinates = (width // 2, height // 2)

# Set the white pixel
image.putpixel(white_pixel_coordinates, (255, 255, 255))

# Save the image
image.save('one_white_pixel_2560x1664.png')

# Show the image
image.show()
