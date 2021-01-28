document.addEventListener("turbolinks:load", function(event) {
  const minuses = document.querySelectorAll('.minus')
    minuses.forEach(function (el) {
      el.addEventListener('click', (function () {
        let input = this.parentNode.querySelector('input');
        input.value = parseInt(input.value) - 1;
        let buttons = document.querySelectorAll(".button.delete-modal.is-success")
        for(let i = 0; i < buttons.length; i++) {
          buttons[i].disabled = false;
        }
      }))
    })
  const pluses = document.querySelectorAll('.plus')
    pluses.forEach(function (el) {
      el.addEventListener('click', (function () {
        let input = this.parentNode.querySelector('input');
        input.value = parseInt(input.value) + 1;
        let buttons = document.querySelectorAll(".button.delete-modal.is-success")
        for(let i = 0; i < buttons.length; i++) {
          buttons[i].disabled = false;
        }
      }))
    })
});
