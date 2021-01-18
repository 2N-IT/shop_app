document.addEventListener("DOMContentLoaded", function(event) {
  const controls = document.querySelectorAll('.modal-control')

  controls.forEach(function(control) {
    control.addEventListener('click', function(event) {
      event.preventDefault();
      let modal = document.querySelector(`#modal${control.dataset.modal_id}`);
      let html = document.querySelector('html');
      modal.classList.add('is-active');
      html.classList.add('is-clipped');
    });
  })
  const closeControls = document.querySelectorAll('.modal-background, .delete, .delete-modal')

  closeControls.forEach(function (ctr) {
    ctr.addEventListener('click', function(e) {
      e.preventDefault();
      const modals = document.querySelectorAll('.modal')
      modals.forEach(function (modal){modal.classList.remove('is-active');})
      document.querySelector('html').classList.remove('is-clipped');
    })
  })
})

