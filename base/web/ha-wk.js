customElements.define('ha-wk',
class extends HTMLElement {
  static get observedAttributes() {
    return [];
  }
  constructor() {
    //
    super();
    this.attachShadow({ mode: 'open' });
    this.shadowRoot.adoptedStyleSheets = [sharedStyles];
    this.shadowRoot.innerHTML = `
      <style>
        :host {
          display: flex;
          flex-direction: column;
          border: 1px solid var(--f4);
        }
        section {
           display: flex;
           flex-wrap: nowrap;
           justify-content: between;
           alignt-items: center;
           gap: 4px;
           padding: 8px;
           background-color: var(--b2);
        }
        #breadcrumbs {
          display: flex;
          flex-wrap: wrap;
          gap: 4px;
          flex-grow: 1;
          background-color: var(--b2);
        }
      </style>
      <template id="button-template">
        <button
          class="b3 hover p1 br1"
          hx-target="closest ha-wk"
          hx-swap="innerHTML"
          slot="crumbs"
          >
        </button>
      </template>
      <section>
        <div id="breadcrumbs">
          <slot id="btns" name="crumbs"></slot>
        </div>
        <div id="actions">
          <button
                 onclick="this.getRootNode().host.inspect()"
                 class="b3 hover p1 br1"
            id="stud"
            ></button>
        </div>
      </section>
      <slot id="slot"></slot>
    `;
  }
  connectedCallback() {
    //
    this.gid("slot").addEventListener("slotchange", (e) => {
      let nodes = e.target.assignedNodes();
      let btns = this.gid("breadcrumbs");
      this.gid("btns").assignedNodes().forEach(n => n.remove())
      if (nodes.length) {
        let wrapped = nodes[0];
        this.gid("stud").textContent = `%${wrapped.getAttribute("stud") || ''}`
        if (wrapped.hasAttribute("here")) {
          let here = wrapped.getAttribute("here");
          let label = wrapped.getAttribute("label");
          this.setAttribute("here", here);
          if (label) {
            this.setAttribute("label", label)
          } else {
            this.removeAttribute("label");
          }
          //
          let segments = here.split("/");
          if (segments.slice(-1)[0] === "") {
            // trim on / path
            segments = segments.slice(0, -1);
          }
          segments.forEach((s, i) => {
            let btn = this.gid('button-template').content.cloneNode(true);
            btn = btn.querySelector('button');
            let dest = segments.slice(0, i+1).join("/")
            btn.setAttribute("hx-get", `/neo/hawk${dest}`)
            btn.textContent = s || "/";
            this.appendChild(btn);
          })
          htmx.process(document.body);
        } else {
          this.removeAttribute("here");
          this.removeAttribute("label");
        }
        const event = new CustomEvent('here-change', {composed: true});
        this.dispatchEvent(event);
      }
    })
  }
  attributeChangedCallback(name, oldValue, newValue) {
    //
  }
  gid(id) {
    //
    return this.shadowRoot.getElementById(id);
  }
  inspect() {
    const event = new CustomEvent('inspect-hawk', {
      bubbles: true,
      composed: true,
      detail: {
        stud: this.getAttribute("stud")
      }
    });
    this.dispatchEvent(event);
  }
})
