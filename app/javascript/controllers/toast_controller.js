import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toast"
export default class extends Controller {
  connect() {
    setTimeout(() => this.show(), 300);
  }

  show() {
    this.element.classList.remove("translate-x-full", "opacity-0");
    this.element.classList.add("translate-x-0", "opacity-100");
  }

  hide() {
    this.element.classList.remove("mr-4");
    this.element.classList.add("opacity-0", "translate-x-full");
    setTimeout(() => this.element.remove(), 1000);
  }

  close() {
    this.hide();
  }
}
