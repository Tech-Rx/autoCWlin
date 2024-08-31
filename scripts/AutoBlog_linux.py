from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
import time
import random

# Function to mimic human scrolling behavior
def human_scroll(driver):
    scroll_pause_time = random.uniform(1, 3)
    scrolls = random.randint(2, 5)
    for _ in range(scrolls):
        driver.execute_script("window.scrollBy(0, window.innerHeight);")
        time.sleep(scroll_pause_time)
        driver.execute_script("window.scrollBy(0, -window.innerHeight);")
        time.sleep(scroll_pause_time)

# Function to perform random clicks on the page
def perform_random_clicks(driver):
    elements = driver.find_elements(By.XPATH, "//a[@href] | //button")
    for _ in range(random.randint(2, 4)):  # Perform 2-4 clicks
        if elements:
            element = random.choice(elements)
            try:
                WebDriverWait(driver, 10).until(EC.element_to_be_clickable(element))
                ActionChains(driver).move_to_element(element).click().perform()
                time.sleep(random.uniform(1, 3))  # Pause after clicking
            except Exception as e:
                print(f"Click error: {e}")

# Function to handle popunder ads
def handle_popunder(driver):
    try:
        ad_element = WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.XPATH, '/html/body/div/div/a/img')))
        ad_element.click()
        time.sleep(5)
        driver.switch_to.window(driver.window_handles[-1])
        driver.close()
        driver.switch_to.window(driver.window_handles[0])
        print("Popunder ad clicked.")
    except Exception as e:
        print(f"Popunder Ad error: {e}")

# Function to handle native ads
def handle_native_ad(driver):
    try:
        ad_element = WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.XPATH, '//*[@id="container-12c2e67f7e93d5f2830289dd3691f899"]/div[2]/div/div/a')))
        ad_element.click()
        time.sleep(random.uniform(5, 10))
        driver.switch_to.window(driver.window_handles[-1])
        driver.close()
        driver.switch_to.window(driver.window_handles[0])
        print("Native ad clicked.")
    except Exception as e:
        print(f"Native Ad error: {e}")

# Function to handle full-screen ads that prevent the first click
def handle_fullscreen_ad(driver):
    try:
        ad_element = WebDriverWait(driver, 10).until(EC.presence_of_element_located((By.XPATH, '//*[@id="lkbyh"]')))
        ad_element.click()
        time.sleep(random.uniform(5, 10))
        driver.switch_to.window(driver.window_handles[-1])
        driver.close()
        driver.switch_to.window(driver.window_handles[0])
        print("Full-screen ad clicked.")
    except Exception as e:
        print(f"Full-screen Ad error: {e}")

# Function to handle any additional tabs
def handle_additional_tabs(driver, original_window_handle):
    for handle in driver.window_handles:
        if handle != original_window_handle:
            driver.switch_to.window(handle)
            print("Closing additional tab...")
            try:
                time.sleep(30)  # Wait for 30 seconds before closing the tab
            except Exception as e:
                print(f"Error during wait: {e}")
            try:
                driver.close()
            except Exception as e:
                print(f"Error closing tab: {e}")
            driver.switch_to.window(original_window_handle)

# List of blog URLs
blogs = [
    "https://amabsaralam.blogspot.com/",
    "https://amabsaralam.blogspot.com/2024/08/passive-income-by-docker-codespaces.html",
    "https://amabsaralam.blogspot.com/2023/04/massive-increase-in-fps-by-using-pgt.html"
]

# Setting up Chrome options for headless mode
chrome_options = Options()
chrome_options.add_argument("--headless")  # Run in headless mode
chrome_options.add_argument("--disable-gpu")
chrome_options.add_argument("--disable-popup-blocking")
chrome_options.add_argument("--disable-notifications")
chrome_options.add_argument("--no-sandbox")
chrome_options.add_argument("--disable-dev-shm-usage")

# Path to ChromeDriver on Linux
service = Service('/usr/local/bin/chromedriver')

driver = webdriver.Chrome(service=service, options=chrome_options)

try:
    for _ in range(random.randint(100, 150)):
        # Choose a random blog to visit
        blog_url = random.choice(blogs)
        driver.get(blog_url)
        original_window_handle = driver.current_window_handle
        
        # Scroll to mimic human behavior
        human_scroll(driver)
        
        # Perform random clicks on the page
        perform_random_clicks(driver)
        
        # Handle ads with increased frequency
        handle_popunder(driver)
        handle_native_ad(driver)
        handle_fullscreen_ad(driver)

        # Handle any additional tabs that might open
        handle_additional_tabs(driver, original_window_handle)

        # Stay on the page for a random time
        time.sleep(random.uniform(60, 180))

        # Wait for a random interval before the next visit
        time.sleep(random.uniform(600, 1800))

finally:
    driver.quit()
