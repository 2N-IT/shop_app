document.addEventListener("turbolinks:load", function(event) {
  const controls = document.querySelectorAll('.modal-control')

  controls.forEach(function(control) {
    control.addEventListener('click', function(event) {
      let modal = document.querySelector(`#modal${control.dataset.modal_id}`);
      let html = document.querySelector('html');
      modal.classList.add('is-active');
      html.classList.add('is-clipped');
      let buttons = document.getElementsByClassName('delete-modal');
      for(let i = 0; i < buttons.length; i++) {
        buttons[i].disabled = false;
      }
    });
  })
  const closeControls = document.querySelectorAll('.modal-background, .delete, .delete-modal')

  closeControls.forEach(function (ctr) {
    ctr.addEventListener('click', function(e) {
      const modals = document.querySelectorAll('.modal')
      modals.forEach(function (modal){modal.classList.remove('is-active');})
      document.querySelector('html').classList.remove('is-clipped');
    })
  })
})

