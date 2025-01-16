const imageList_encero = [
    { src: 'img/Encero_1.png', alt: 'Image 1' },
    { src: 'img/Encero_2.png', alt: 'Image 2' },
    { src: 'img/Encero_3.png', alt: 'Image 3' },
    { src: 'img/Encero_4.png', alt: 'Image 4' },
];

const imageList_mastermind = [
    { src: 'img/Mastermind_1.png', alt: 'Image 1' },
    { src: 'img/Mastermind_2.png', alt: 'Image 2' },
    { src: 'img/Mastermind_3.png', alt: 'Image 3' },
    { src: 'img/Mastermind_4.png', alt: 'Image 4' },
    { src: 'img/Mastermind_5.png', alt: 'Image 5' },
    { src: 'img/Mastermind_6.png', alt: 'Image 6' },
];

document.addEventListener('DOMContentLoaded', () => {
    const enceroGrid = document.getElementById('encero-grid');
    const mastermindGrid = document.getElementById('mastermind-grid');

    imageList_encero.forEach(image => {
        const gridItem = document.createElement('div');
        gridItem.classList.add('grid__item');
        const img = document.createElement('img');
        img.src = image.src;
        img.alt = image.alt;
        gridItem.appendChild(img);
        enceroGrid.appendChild(gridItem);
    });

    imageList_mastermind.forEach(image => {
        const gridItem = document.createElement('div');
        gridItem.classList.add('grid__item');
        const img = document.createElement('img');
        img.src = image.src;
        img.alt = image.alt;
        gridItem.appendChild(img);
        mastermindGrid.appendChild(gridItem);
    });

    const modal = document.getElementById('myModal');
    const modalImage = document.getElementById('modalImage');
    const modalCaption = document.getElementById('modalCaption');
    const closeBtn = document.querySelector('.close');

    document.querySelectorAll('.grid__item img').forEach(img => {
        img.addEventListener('click', () => {
            modal.style.display = 'block';
            modalImage.src = img.src;
            modalCaption.textContent = img.alt;
        });
    });

    closeBtn.addEventListener('click', () => {
        modal.style.display = 'none';
    });

    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
});
