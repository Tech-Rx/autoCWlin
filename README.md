# Automated Passive Income System

## Setup Instructions

1. **Connect to Your VPS:**

   Use SSH to connect to your VPS.

2. **Download and Run `setup.sh`:**
   ```bash
   wget https://github.com/absaro/autoCWlin/raw/main/setup.sh -O /root/setup.sh
   chmod +x /root/setup.sh
   /root/setup.sh
   ```
   Download the setup script from the GitHub repository, make it executable, and run it.

3. **Run `passive_income.sh`: (Optional, if you didn't run setup.sh)**
   ```bash
   /root/passive_income.sh
   ```
   This script is automatically executed by `setup.sh`. You can run it manually if needed.

## What `setup.sh` Installs and Configures

1. **Google Chrome**: Installs Google Chrome for browsing and interacting with websites.
2. **ChromeDriver**: Installs ChromeDriver to interface with Chrome via Selenium.
3. **Python3**: Installs Python3, which is required for running the Selenium scripts.
4. **Selenium**: Installs the Selenium Python library for browser automation.
5. **Git**: Installs Git to clone the repository.
6. **Docker**: Installs Docker for running passive income apps in containers.

### Additional Configuration

- **Schedules Scripts**: Configures a cron job to run the `run_all_scripts.sh` script daily.
- **Downloads and Configures Passive Income Apps**: The `passive_income.sh` script is downloaded and executed to set up Docker containers for passive income apps.

The `setup.sh` script is responsible for preparing the environment, installing necessary tools, and configuring everything to run your Selenium scripts and passive income apps.

## Script Descriptions

#### 1. `AutoBlog_linux.py`

**Purpose**: Automates interaction with blog websites to simulate human behavior and increase ad revenue.

**Key Functions**:
- **Human Scrolling**: Scrolls up and down the page to mimic human behavior.
- **Random Clicks**: Clicks on random links and buttons on the page.
- **Handle Ads**: Clicks on popunder, native, and full-screen ads, and handles additional tabs.
- **Customizing**: Edit the `blogs` list to include your own blog URLs to increase ad revenue.

**Location**: `/root/scripts/AutoBlog_linux.py`

**How to Modify**:
1. Open the file using a text editor like nano:
```bash
    nano /root/scripts/AutoBlog_linux.py
```
2. Add or modify the URLs in the `blogs` list as needed.
 
 Find the section of the script that looks like this:
```python
# List of blog URLs
blogs = [
    "https://yourblog1.com",
    "https://yourblog2.com",
    "https://yourblog3.com"
]
```
Update it with your blog URLs and save the file.

3. Save and exit the editor.

#### 2. `AutoWatch_linux.py`

**Purpose**: Automates watching YouTube videos to simulate user engagement.

**Key Functions**:
- **Watch Videos**: Visits video URLs and watches them for random durations.
- **Customizing**: Edit the `video_urls` list to include your own YouTube video URLs.

**Location**: `/root/scripts/AutoWatch_linux.py`

**How to Modify**:
1. Open the file using a text editor like nano:
 ```bash
nano /root/scripts/AutoWatch_linux.py
```
3. Add or modify the URLs in the `video_urls` list as needed.

   Find the section of the script that looks like this:
```python
 # List of video URLs in your playlist
video_urls = [
    "https://www.youtube.com/watch?v=your_video_id1",
    "https://www.youtube.com/watch?v=your_video_id2"
]
``` 
3. Save and exit the editor.

## Passive Earning Apps

The `passive_income.sh` script sets up various passive income apps using Docker. Here’s a list of the apps and their estimated earnings:

| App Name       | Estimated Earnings (per month) |
|----------------|--------------------------------|
| Honeygain       | $5 - $20                        |
| Pawns           | $10 - $30                       |
| PacketStream    | $5 - $15                        |
| Repocket        | $10 - $25                       |
| ProxyRack       | $20 - $50                       |
| Mysterium Node  | $20 - $40                       |

## How to Set Up Passive Earning Apps

1. **Ensure Docker is Installed**: Docker will be installed by the `passive_income.sh` script.
2. **Configure Each App**: Edit the `credentials.sh` file with your credentials for each app.
3. **Run the Apps**: The `passive_income.sh` script will start and manage the containers for you.

### Notes

- Make sure to manually create `/root/credentials.sh` with the required format if you haven't already. The `credentials.sh` file in the repository should be modified with your sensitive information.
- Utilize free VPS resources effectively to generate passive income by configuring and running these scripts and applications.

For any issues or further customization, please refer to the scripts or consult the documentation of each application.
