require("trix")
require("@rails/actiontext")

const iconNameFor = (trixAttribute) => {
  switch (trixAttribute) {
    case 'Bold':
      return 'bold';
    case 'Italic':
      return 'italic';
    case 'Strikethrough':
      return 'strikethrough';
    case 'Link':
      return 'link';
    case 'Heading':
      return 'heading';
    case 'Quote':
      return 'quote-right';
    case 'Code':
      return 'code';
    case 'Bullets':
      return 'list';
    case 'Numbers':
      return 'list-ol';
    case 'Decrease Level':
      return 'outdent';
    case 'Increase Level':
      return 'indent';
    case 'Attach Files':
      return 'paperclip';
    case 'Undo':
      return 'undo';
    case 'Redo':
      return 'redo';
  }
}

const trixInit = () => {
  const buttons = document.querySelectorAll('.trix-button--icon');

  buttons.forEach((button) => {
    button.innerHTML = `<i class="fad fa-${iconNameFor(button.title)}"></i>`;
  })
  
  const richTextAreaLabels = document.querySelectorAll('.rich-text-area-label');
  
  richTextAreaLabels.forEach((label) => {
    label.parentElement.querySelector('.trix-button-row').insertAdjacentElement('afterbegin', label);
  })
}

export { trixInit };
