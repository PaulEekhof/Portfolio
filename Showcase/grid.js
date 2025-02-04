const imageList_encero = [
    { src: 'img/Encero_1.png', alt: 'Image 1' },
    { src: 'img/Encero_2.png', alt: 'Image 2' },
    { src: 'img/Encero_3.png', alt: 'Image 3' },
    { src: 'img/Encero_4.png', alt: 'Image 4' },
];

const description_encero = 'This simple application allows users to upload multiple files, specify a custom extension for the package, and download the package along with a key to open it. It also gives the user the ability to open a custom file with a key.';

const imageList_mastermind = [
    { src: 'img/Mastermind_1.png', alt: 'Image 1' },
    { src: 'img/Mastermind_2.png', alt: 'Image 2' },
    { src: 'img/Mastermind_3.png', alt: 'Image 3' },
    { src: 'img/Mastermind_4.png', alt: 'Image 4' },
    { src: 'img/Mastermind_5.png', alt: 'Image 5' },
    { src: 'img/Mastermind_6.png', alt: 'Image 6' },
];

const description_mastermind = 'Mastermind 2025 is a modern Flutter implementation of the classic code-breaking game. Challenge your logic and deduction skills by breaking the secret color code!';

const imageList_fluttercrud = [
    { src: 'img/FlutterCRUD_1.png', alt: 'Image 1' },
    { src: 'img/FlutterCRUD_2.png', alt: 'Image 2' },
    { src: 'img/FlutterCRUD_3.png', alt: 'Image 3' },
    { src: 'img/FlutterCRUD_4.png', alt: 'Image 4' },
    { src: 'img/FlutterCRUD_5.png', alt: 'Image 5' },
    { src: 'img/FlutterCRUD_6.png', alt: 'Image 6' },
];

const description_fluttercrud = 'This project is a simple CRUD (Create, Read, Update, Delete) application built with Flutter. It includes a custom drawer for easy navigation between different screens.';

const imageList_personal_budget = [
    { src: 'img/Personal_Budget_1.png', alt: 'Image 1' },
    { src: 'img/Personal_Budget_2.png', alt: 'Image 2' },
    { src: 'img/Personal_Budget_3.png', alt: 'Image 3' },
    { src: 'img/Personal_Budget_4.png', alt: 'Image 4' },
    { src: 'img/Personal_Budget_5.png', alt: 'Image 5' },
    { src: 'img/Personal_Budget_6.png', alt: 'Image 6' },
    { src: 'img/Personal_Budget_7.png', alt: 'Image 7' },
];

const description_personal_budget = 'This is a personal expense management application built with Python and customtkinter.';

const imageList_chart_lemming = [
    { src: 'img/Chart_Lemming_1.png', alt: 'Image 1' },
    { src: 'img/Chart_Lemming_2.png', alt: 'Image 2' },
    { src: 'img/Chart_Lemming_3.png', alt: 'Image 3' },
    { src: 'img/Chart_Lemming_4.png', alt: 'Image 4' },
    { src: 'img/Chart_Lemming_5.png', alt: 'Image 5' },
    { src: 'img/Chart_Lemming_6.png', alt: 'Image 6' },
    { src: 'img/Chart_Lemming_7.png', alt: 'Image 7' },
];

const description_chart_lemming = 'Chart Lemming is a web application that enables users to upload CSV data, select a chart type, and display the chosen chart on an HTML page. Users can seamlessly switch between different chart types for the uploaded data and view detailed explanations for each chart. The explanations are generated by a custom-trained AI model. This package also includes the model trainer, chart creator, explanation creator, file converter, and predictor model.';

const imageList_nova_caster =[
    { src: 'img/Nova_Caster_1.png', alt: 'Image 1' },
    { src: 'img/Nova_Caster_2.png', alt: 'Image 2' },
]

const description_nova_caster = 'A Python application that combines mathematical pattern recognition with AI-powered predictions using GGUF models to predict the next number in a sequence.';

document.addEventListener('DOMContentLoaded', () => {
    const enceroGrid = document.getElementById('encero-grid');
    const mastermindGrid = document.getElementById('mastermind-grid');
    const fluttercrudGrid = document.getElementById('fluttercrud-grid');
    const personalBudgetGrid = document.getElementById('personal-budget-grid');
    const chartLemmingGrid = document.getElementById('chart-lemming-grid');
    const novaCasterGrid = document.getElementById('nova-caster-grid');

    const enceroDescription = document.createElement('p');
    enceroDescription.textContent = description_encero;
    enceroGrid.parentNode.insertBefore(enceroDescription, enceroGrid);

    const mastermindDescription = document.createElement('p');
    mastermindDescription.textContent = description_mastermind;
    mastermindGrid.parentNode.insertBefore(mastermindDescription, mastermindGrid);

    const fluttercrudDescription = document.createElement('p');
    fluttercrudDescription.textContent = description_fluttercrud;
    fluttercrudGrid.parentNode.insertBefore(fluttercrudDescription, fluttercrudGrid);

    const personalBudgetDescription = document.createElement('p');
    personalBudgetDescription.textContent = description_personal_budget;
    personalBudgetGrid.parentNode.insertBefore(personalBudgetDescription, personalBudgetGrid);

    const chartLemmingDescription = document.createElement('p');
    chartLemmingDescription.textContent = description_chart_lemming;
    chartLemmingGrid.parentNode.insertBefore(chartLemmingDescription, chartLemmingGrid);

    const novaCasterDescription = document.createElement('p');
    novaCasterDescription.textContent = description_nova_caster;
    novaCasterGrid.parentNode.insertBefore(novaCasterDescription, novaCasterGrid);

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

    imageList_fluttercrud.forEach(image => {
        const gridItem = document.createElement('div');
        gridItem.classList.add('grid__item');
        const img = document.createElement('img');
        img.src = image.src;
        img.alt = image.alt;
        gridItem.appendChild(img);
        fluttercrudGrid.appendChild(gridItem);
    });

    imageList_personal_budget.forEach(image => {
        const gridItem = document.createElement('div');
        gridItem.classList.add('grid__item');
        const img = document.createElement('img');
        img.src = image.src;
        img.alt = image.alt;
        gridItem.appendChild(img);
        personalBudgetGrid.appendChild(gridItem);
    });

    imageList_chart_lemming.forEach(image => {
        const gridItem = document.createElement('div');
        gridItem.classList.add('grid__item');
        const img = document.createElement('img');
        img.src = image.src;
        img.alt = image.alt;
        gridItem.appendChild(img);
        chartLemmingGrid.appendChild(gridItem);
    });

    imageList_nova_caster.forEach(image => {
        const gridItem = document.createElement('div');
        gridItem.classList.add('grid__item');
        const img = document.createElement('img');
        img.src = image.src;
        img.alt = image.alt;
        gridItem.appendChild(img);
        novaCasterGrid.appendChild(gridItem);
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
