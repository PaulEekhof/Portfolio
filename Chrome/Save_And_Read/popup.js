document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('saveButton').addEventListener('click', () => {
    console.log('Save button clicked');
    chrome.tabs.query({active: true, currentWindow: true}, tabs => {
      if (tabs.length === 0) return;
      const tab = tabs[0];
      const description = document.getElementById('descriptionInput').value;
      const note = document.getElementById('noteInput').value;
      const savedTab = {
        title: tab.title,
        url: tab.url,
        description: description,
        note: note,
        savedAt: new Date().toISOString()
      };
      chrome.storage.sync.get({savedTabs: []}, result => {
        const savedTabs = result.savedTabs;
        savedTabs.push(savedTab);
        chrome.storage.sync.set({savedTabs: savedTabs}, () => {
          console.log('Tab saved:', savedTab);
          // Show notification
          alert('Tab saved successfully!');
          // Clear input fields
          document.getElementById('descriptionInput').value = '';
          document.getElementById('noteInput').value = '';
        });
      });
    });
  });

  document.getElementById('readButton').addEventListener('click', () => {
    console.log('Read button clicked');
    chrome.storage.sync.get({savedTabs: []}, result => {
      const savedTabs = result.savedTabs;
      const container = document.getElementById('savedTabsContainer');
      container.innerHTML = '';
      savedTabs.forEach((tab, index) => {
        const tabDiv = document.createElement('div');
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
            document.getElementById('readButton').click();
          });
        });
      });
    });
  });

  document.getElementById('openSavedPageButton').addEventListener('click', () => {
    console.log('Open Saved Page button clicked');
    chrome.tabs.create({url: chrome.runtime.getURL('saved.html')});
  });

  document.getElementById('saveOfflineButton').addEventListener('click', () => {
    console.log('Save Offline button clicked');
    chrome.tabs.query({active: true, currentWindow: true}, tabs => {
      if (tabs.length === 0) return;
      const tab = tabs[0];
      const description = document.getElementById('descriptionInput').value;
      const note = document.getElementById('noteInput').value;
      const savedTab = {
        title: tab.title,
        url: tab.url,
        description: description,
        note: note,
        savedAt: new Date().toISOString()
      };
      const blob = new Blob([JSON.stringify(savedTab)], {type: 'application/json'});
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `${tab.title}.json`;
      a.click();
      URL.revokeObjectURL(url);
      alert('Tab saved offline successfully!');
      document.getElementById('descriptionInput').value = '';
      document.getElementById('noteInput').value = '';
    });
  });
});
