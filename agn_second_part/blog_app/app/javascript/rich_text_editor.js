// rich text editor functionality for blog posts
document.addEventListener('turbo:load', () => {
  const editor = document.getElementById('blog-editor');
  if (!editor) return;

  const hiddenField = document.getElementById('blog_body');
  if (!hiddenField) {
    console.error('Hidden field blog_body not found');
    return;
  }
  
  console.log('Rich text editor initialized');
  
  // initialize editor content from hidden field
  if (hiddenField.value) {
    editor.innerHTML = hiddenField.value;
  }

  // update hidden field on content change
  editor.addEventListener('input', () => {
    hiddenField.value = editor.innerHTML;
    console.log('Content updated:', editor.innerHTML.substring(0, 50));
  });

  // also update hidden field before form submission
  const form = editor.closest('form');
  if (form) {
    form.addEventListener('submit', (e) => {
      hiddenField.value = editor.innerHTML;
      console.log('Form submitting with body:', hiddenField.value.substring(0, 100));
    });
  }

  // formatting functions
  function execCommand(command, value = null) {
    document.execCommand(command, false, value);
    editor.focus();
  }

  // bold button
  document.getElementById('bold-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('bold');
  });

  // italic button
  document.getElementById('italic-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('italic');
  });

  // underline button
  document.getElementById('underline-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('underline');
  });

  // heading buttons
  document.getElementById('h1-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('formatBlock', '<h1>');
  });

  document.getElementById('h2-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('formatBlock', '<h2>');
  });

  document.getElementById('h3-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('formatBlock', '<h3>');
  });

  // paragraph button
  document.getElementById('p-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('formatBlock', '<p>');
  });

  // ordered list
  document.getElementById('ol-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('insertOrderedList');
  });

  // unordered list
  document.getElementById('ul-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('insertUnorderedList');
  });

  // color picker
  const colorPicker = document.getElementById('color-picker');
  const colorBtn = document.getElementById('color-btn');
  
  colorBtn?.addEventListener('click', (e) => {
    e.preventDefault();
    colorPicker.click();
  });

  colorPicker?.addEventListener('change', (e) => {
    execCommand('foreColor', e.target.value);
  });

  // highlight color
  const highlightPicker = document.getElementById('highlight-picker');
  const highlightBtn = document.getElementById('highlight-btn');
  
  highlightBtn?.addEventListener('click', (e) => {
    e.preventDefault();
    highlightPicker.click();
  });

  highlightPicker?.addEventListener('change', (e) => {
    execCommand('backColor', e.target.value);
  });

  // link insertion
  document.getElementById('link-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    const url = prompt('Enter URL:');
    if (url) {
      const selection = window.getSelection();
      if (selection.toString()) {
        const link = document.createElement('a');
        link.href = url;
        link.target = '_blank';
        link.rel = 'noopener noreferrer';
        link.textContent = selection.toString();
        
        const range = selection.getRangeAt(0);
        range.deleteContents();
        range.insertNode(link);
      } else {
        alert('Please select text first to create a link');
      }
    }
  });

  // image upload
  const imageInput = document.getElementById('image-input');
  document.getElementById('image-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    imageInput.click();
  });

  imageInput?.addEventListener('change', (e) => {
    const file = e.target.files[0];
    if (file && file.type.startsWith('image/')) {
      const reader = new FileReader();
      reader.onload = (event) => {
        const img = document.createElement('img');
        img.src = event.target.result;
        img.style.maxWidth = '100%';
        img.style.height = 'auto';
        img.style.margin = '1rem 0';
        img.style.borderRadius = '8px';
        
        // insert image at cursor position
        const selection = window.getSelection();
        if (selection.rangeCount > 0) {
          const range = selection.getRangeAt(0);
          range.insertNode(img);
          
          // add line break after image
          const br = document.createElement('br');
          img.parentNode.insertBefore(br, img.nextSibling);
        } else {
          editor.appendChild(img);
        }
        
        // update hidden field
        hiddenField.value = editor.innerHTML;
      };
      reader.readAsDataURL(file);
    }
  });

  // clear formatting
  document.getElementById('clear-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('removeFormat');
  });

  // align buttons
  document.getElementById('align-left-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('justifyLeft');
  });

  document.getElementById('align-center-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('justifyCenter');
  });

  document.getElementById('align-right-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('justifyRight');
  });

  // quote button
  document.getElementById('quote-btn')?.addEventListener('click', (e) => {
    e.preventDefault();
    execCommand('formatBlock', '<blockquote>');
  });
});
