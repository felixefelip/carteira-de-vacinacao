import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trigger"]

  alternar(event) {
    event.stopPropagation()
    this.#definirAberto(!this.element.classList.contains("nav-menu--open"))
  }

  fechar() {
    this.#definirAberto(false)
  }

  fecharAoClicarFora(event) {
    if (!this.element.contains(event.target)) this.fechar()
  }

  fecharAoSair(event) {
    if (!this.element.contains(event.relatedTarget)) this.fechar()
  }

  fecharComEscape() {
    this.fechar()
    this.triggerTarget.focus()
  }

  #definirAberto(aberto) {
    this.element.classList.toggle("nav-menu--open", aberto)
    this.triggerTarget.setAttribute("aria-expanded", aberto)
  }
}
