const imageList_encero = [
    { src: 'img/Encero_1.png', alt: 'Image 1' },
    { src: 'img/Encero_2.png', alt: 'Image 2' },
    { src: 'img/Encero_3.png', alt: 'Image 3' },
    { src: 'img/Encero_4.png', alt: 'Image 4' },
];

const imageList_quizzy = [
    { src: 'img/Quizzy_1.png', alt: 'Image 1' },
    { src: 'img/Quizzy_2.png', alt: 'Image 2' },
    { src: 'img/Quizzy_3.png', alt: 'Image 3' },
    { src: 'img/Quizzy_4.png', alt: 'Image 4' },
];

document.addEventListener('DOMContentLoaded', () => {
    const grid = document.querySelector('.grid');
    imageList_encero.forEach(image => {
        const gridItem = document.createElement('div');
        gridItem.classList.add('grid__item');
        const img = document.createElement('img');
        img.src = image.src;
        img.alt = image.alt;
        gridItem.appendChild(img);
        grid.appendChild(gridItem);
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
