// Ensure that the Chart.js library is included in your HTML file
// <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

document.addEventListener('DOMContentLoaded', function () {
    const histogramCtx = document.getElementById('chartCanvas').getContext('2d');
    const myHistogramChart = new Chart(histogramCtx, {
        type: 'bar', // Use 'bar' chart type for histogram
        data: {
            labels: ['Bin 1', 'Bin 2', 'Bin 3', 'Bin 4', 'Bin 5'],
            datasets: [{
                label: 'Frequency',
                data: [12, 19, 3, 5, 2], // Example data, replace with actual binned data
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
                        text: 'Bins'
                    }
                },
                y: {
                    display: true,
                    title: {
                        display: true,
                        text: 'Frequency'
                    },
                    beginAtZero: true
                }
            }
        }
    });
});
