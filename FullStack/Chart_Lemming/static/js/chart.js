document.addEventListener('DOMContentLoaded', function () {
    const ctx = document.getElementById('chartCanvas').getContext('2d');
    let myChart = new Chart(ctx, {
        type: 'bar', // Default chart type
        data: {
            labels: [],
            datasets: [{
                label: 'Dataset',
                data: [],
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                x: {
                    display: true,
                    title: {
                        display: true,
                        text: 'X Axis'
                    }
                },
                y: {
                    display: true,
                    title: {
                        display: true,
                        text: 'Y Axis'
                    },
                    beginAtZero: true
                }
            }
        }
    });

    function updateChartData(newData, newLabels, newType, explanation) {
        myChart.destroy(); // Destroy the old chart instance
        myChart = new Chart(ctx, {
            type: newType.toLowerCase(),
            data: {
                labels: newLabels,
                datasets: [{
                    label: 'Dataset',
                    data: newData,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    x: {
                        display: true,
                        title: {
                            display: true,
                            text: 'X Axis'
                        }
                    },
                    y: {
                        display: true,
                        title: {
                            display: true,
                            text: 'Y Axis'
                        },
                        beginAtZero: true
                    }
                }
            }
        });

        // Update explanation
        updateExplanation(explanation);
    }

    function fetchChartData(chartType, chartParams) {
        const formData = new FormData();
        formData.append('file', document.getElementById('file').files[0]);
        formData.append('chartType', chartType);

        fetch('/upload', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            console.log(data.message);
            // Update the chart with new data here
            updateChartData(data.newData, data.newLabels, chartType, data.explanation);
        })
        .catch(error => console.error('Error:', error));
    }

    function updateChart() {
        var selectedType = document.getElementById('chartType').value;
        fetchChartData(selectedType, ['Month', 'Value']);
    }

    document.querySelector('form').addEventListener('submit', function (event) {
        event.preventDefault();
        updateChart();
    });
});
