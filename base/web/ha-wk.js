customElements.define('ha-wk',
class extends HTMLElement {
  static get observedAttributes() {
    return ["stud", "here", "label"];
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
          position: relative;
        }
        section {
          position: sticky;
          z-index: 10;
          top: 0;
          left: 0;
          display: flex;
          flex-wrap: wrap;
          justify-content: between;
          alignt-items: center;
          gap: 8px;
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
        aside {
          flex-basis: 100%;
        }
      </style>
      <template id="button-template">
        <button
          class="b2 hover p1 br1 mono"
          hx-target="closest ha-wk"
          hx-swap="innerHTML"
          slot="crumbs"
          >
        </button>
      </template>
      <section>
        <button
          class="b2 hover p1 br1 mono f2"
          onclick="this.getRootNode().host.toggleTree(event)"
          slot="crumbs"
          >
          z
        </button>
        <button
          class="b2 hover p1 br1 mono f2"
          onclick="this.getRootNode().host.toggleMore(event)"
          slot="crumbs"
          >
          #
        </button>
        <div id="breadcrumbs">
          <slot id="btns" name="crumbs"></slot>
        </div>
        <div id="actions" class="f2">
          <button
            class="b2 hover p1 br1 mono"
            onclick="this.getRootNode().host.clone(event)"
            slot="crumbs"
            >
            c
          </button>
          <button
            class="b2 hover p1 br1 mono"
            onclick="this.getRootNode().host.raise(event)"
            slot="crumbs"
            >
            &lt;
          </button>
          <button
            class="b2 hover p1 br1 mono"
            onclick="this.getRootNode().host.drop(event)"
            slot="crumbs"
            >
            &gt;
          </button>
          <button
            class="b2 hover p1 br1 mono"
            onclick="this.getRootNode().host.burry(event)"
            slot="crumbs"
            >
            _
          </button>
          <button
            class="b2 hover p1 br1 mono"
            onclick="this.getRootNode().host.suicide()"
            slot="crumbs"
            >
            X
          </button>
        </div>
        <aside id="aside" class="hidden p3 b3 fc g3 br1">
          <div class="frw g2">
            <button
              onclick="this.getRootNode().host.inspect()"
              class="b3 hover p1 br1 mono"
              id="stud"
              ></button>
          </div>
        </aside>
        <div id="tree" class="hidden p3 b3 fc g3 br1 basis-full">
          <h1 class="bold">tree</h1>
          <p>not yet implemented</p>
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
        this.setAttribute("stud", wrapped.getAttribute("stud"));
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
            btn.textContent = s + "/";
            this.appendChild(btn);
          })
          htmx.process(document.body);
        } else {
          this.removeAttribute("here");
          this.removeAttribute("label");
        }
      }
      console.log('here-change', this);
      const event = new CustomEvent('here-change', {composed: true});
      this.dispatchEvent(event);
    })
  }
  attributeChangedCallback(name, oldValue, newValue) {
    //
    if (name === "stud") {
      this.gid("stud").textContent = `%${newValue}`
    } else if (name === "here") {
      const event = new CustomEvent('true', {
        bubbles: true,
        composed: true,
      });
      this.dispatchEvent(event);
    } else if (name === "label") {
      const event = new CustomEvent('true', {
        bubbles: true,
        composed: true,
      });
      this.dispatchEvent(event);
    }
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
  toggleMore(e) {
    this.gid("aside").classList.toggle("hidden");
    e.target.classList.toggle("b3");
  }
  toggleTree(e) {
    this.gid("tree").classList.toggle("hidden");
    e.target.classList.toggle("b3");
  }
  clone() {
    const event = new CustomEvent('clone-hawk', {
      bubbles: true,
      composed: true,
      detail: {
        here: this.getAttribute("here"),
        slot: this.getAttribute("slot"),
      }
    });
    this.dispatchEvent(event);
  }
  burry() {
    this.parentNode.insertAdjacentElement("beforeend", this);
    const event = new CustomEvent('cull', {
      bubbles: true,
      composed: true,
    });
    this.dispatchEvent(event);
  }
  drop() {
    this.nextElementSibling?.insertAdjacentElement("afterend", this);
    const event = new CustomEvent('true', {
      bubbles: true,
      composed: true,
    });
    this.dispatchEvent(event);
  }
  raise() {
    this.previousElementSibling?.insertAdjacentElement("beforebegin", this);
    const event = new CustomEvent('true', {
      bubbles: true,
      composed: true,
    });
    this.dispatchEvent(event);
  }
  shoot() {
    this.parentNode.insertAdjacentElement("afterbegin", this);
    const event = new CustomEvent('true', {
      bubbles: true,
      composed: true,
    });
    this.dispatchEvent(event);
  }
  suicide() {
    let par = this.parentNode;
    this.remove();
    const event = new CustomEvent('true', {
      bubbles: true,
      composed: true,
    });
    par.dispatchEvent(event);
  }
})
