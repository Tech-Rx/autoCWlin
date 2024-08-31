from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import random

# Path to your ChromeDriver
chrome_driver_path = '/usr/local/bin/chromedriver'

# Chrome options for headless mode
chrome_options = Options()
chrome_options.add_argument("--headless")  # Run Chrome in headless mode
chrome_options.add_argument("--mute-audio")  # Mute the audio

# Initialize the WebDriver
service = Service(chrome_driver_path)
driver = webdriver.Chrome(service=service, options=chrome_options)

# List of video URLs in your playlist
video_urls = [
    "https://www.youtube.com/watch?v=f6eytrdU-l0&list=PLitsa5uERBtC76L9M8nrV77TrFrS9lEcW&index=1",
    "https://www.youtube.com/watch?v=ZVv_7Jeuwx4&list=PLitsa5uERBtC76L9M8nrV77TrFrS9lEcW&index=2"
]

def watch_video(url):
    driver.get(url)
    
    try:
        # Wait for the video to start playing
        WebDriverWait(driver, 20).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, "video"))
        )
        time.sleep(random.randint(60, 120))  # Watch for a random duration between 60 and 120 seconds

    except Exception as e:
        print(f"Error while watching video: {e}")

# Function to run the script
def run_script():
    for _ in range(random.randint(100, 120)):
        url = random.choice(video_urls)
        watch_video(url)
        # Sleep to ensure random intervals between views
        time.sleep(random.randint(300, 600))  # Sleep between 5 to 10 minutes

# Ensure to visit youtube.com first
driver.get("https://www.youtube.com")
WebDriverWait(driver, 20).until(
    EC.presence_of_element_located((By.CSS_SELECTOR, "ytd-app"))
)

# Run the script to watch videos
run_script()

# Close the driver
driver.quit()
