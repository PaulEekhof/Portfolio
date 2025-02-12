document.addEventListener('DOMContentLoaded', async () => {
    const quakesList = document.getElementById("quakesList");
    const checkNow = document.getElementById("checkNow");
    const loading = document.getElementById("loading");

    function getMagnitudeClass(magnitude) {
        if (magnitude >= 5.0) return 'strong';
        if (magnitude >= 4.0) return 'moderate';
        return 'light';
    }

    async function displayQuakes() {
        loading.style.display = 'block';
        quakesList.style.display = 'none';

        const data = await chrome.storage.local.get('recentQuakes');
        const quakes = data.recentQuakes || [];
        
        quakesList.innerHTML = quakes.map(quake => `
            <a href="${quake.url}" 
               class="quake-item" 
               target="_blank" 
               rel="noopener noreferrer">
                <div class="magnitude ${getMagnitudeClass(quake.magnitude)}">
                    M ${quake.magnitude.toFixed(1)}
                </div>
                <div class="place">${quake.place}</div>
                <div class="time">${quake.time}</div>
            </a>
        `).join('');

        loading.style.display = 'none';
        quakesList.style.display = 'block';
    }

    checkNow.addEventListener("click", async () => {
        checkNow.disabled = true;
        chrome.runtime.sendMessage({ action: "fetchData" });
        setTimeout(async () => {
            await displayQuakes();
            checkNow.disabled = false;
        }, 1000);
    });

    displayQuakes();
});

chrome.runtime.onMessage.addListener((message) => {
    if (message.type === "alert") {
        alert(message.text);
    }
});
