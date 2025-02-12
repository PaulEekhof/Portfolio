async function fetchEarthquakeData() {
    try {
        const response = await fetch("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson");
        const data = await response.json();
        
        // Store last 3 significant earthquakes
        const significantQuakes = data.features
            .slice(0, 3)
            .map(quake => ({
                magnitude: quake.properties.mag,
                place: quake.properties.place,
                time: new Date(quake.properties.time).toLocaleString(),
                url: quake.properties.url
            }));
        
        await chrome.storage.local.set({ recentQuakes: significantQuakes });

        // Check for significant earthquakes
        const strongestQuake = data.features[0];
        if (strongestQuake && strongestQuake.properties.mag >= 5.0) {
            chrome.notifications.create({
                type: "basic",
                iconUrl: "icon.png",
                title: "Significant Earthquake Alert!",
                message: `Magnitude ${strongestQuake.properties.mag} earthquake detected near ${strongestQuake.properties.place}`
            });
        }
    } catch (error) {
        console.error("Error fetching earthquake data:", error);
    }
}

chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
    if (message.action === "fetchData") {
        fetchEarthquakeData();
    }
});

// Run every 10 minutes
chrome.alarms.create("quakeCheck", { periodInMinutes: 10 });
chrome.alarms.onAlarm.addListener(fetchEarthquakeData);
