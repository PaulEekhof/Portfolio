// Include Chart.js library
// <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

const scatterCtx = document.getElementById('scatterChart').getContext('2d');
const myScatterChart = new Chart(scatterCtx, {
    type: 'scatter',
    data: {
        datasets: [{
            label: 'Scatter Dataset',
            data: [
                { x: -10, y: 0 },
                { x: 0, y: 10 },
                { x: 10, y: 5 },
                { x: 0.5, y: 5.5 }
            ],
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            borderColor: 'rgba(75, 192, 192, 1)'
        }]
    },
    options: {
        scales: {
            x: {
                type: 'linear',
                position: 'bottom',
                title: {
                    display: true,
                    text: 'X-axis'
                }
            },
            y: {
                title: {
                    display: true,
                    text: 'Y-axis'
                }
            }
        }
    }
});
