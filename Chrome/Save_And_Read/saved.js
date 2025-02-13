document.addEventListener('DOMContentLoaded', () => {
  chrome.storage.sync.get({savedTabs: []}, result => {
    const savedTabs = result.savedTabs;
    const container = document.getElementById('savedTabsContainer');
    container.innerHTML = '';
    savedTabs.forEach((tab, index) => {
      const tabDiv = document.createElement('div');
      tabDiv.className = 'tab';
      const savedDate = new Date(tab.savedAt);
      const formattedDate = savedDate.toLocaleString();
      tabDiv.innerHTML = `<strong>${tab.title}</strong><br>
                          ${tab.description}<br>
                          Note: ${tab.note}<br>
                          Saved at: ${formattedDate}<br>
                          <button class="deleteButton" data-index="${index}">Delete</button>`;
      tabDiv.addEventListener('click', () => {
         chrome.tabs.create({url: tab.url});
      });
      container.appendChild(tabDiv);
    });

    // Add event listeners to delete buttons
    document.querySelectorAll('.deleteButton').forEach(button => {
      button.addEventListener('click', (event) => {
        event.stopPropagation();
        const index = event.target.getAttribute('data-index');
        savedTabs.splice(index, 1);
        chrome.storage.sync.set({savedTabs: savedTabs}, () => {
          console.log('Tab deleted');
          location.reload();
        });
      });
    });
  });
});
