import { Controller } from "stimulus"

export default class extends Controller {
	static targets = [ "text", "confirmation" ]

  select() {
  	let selection = window.getSelection();

	  if (selection.rangeCount > 0) {
	    selection.removeAllRanges();
	  }

    let range = document.createRange();
    range.selectNode(this.textTarget);
    selection.addRange(range);

    document.execCommand("copy");

    let confirmation = this.confirmationTarget;
    confirmation.classList.remove("hidden");

    // const originalText = target.textContent;
    // target.textContent = "Copied!";
    window.setTimeout(function() {
    	confirmation.classList.add("hidden");
    }, 2000);
  }
}
