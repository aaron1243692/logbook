import './bootstrap';
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import './egate-admin-shell';
import './egate-dashboard';

document.addEventListener('DOMContentLoaded', () => {
    let activeTrigger = null;
    let originalTitle = '';
    const tooltip = document.createElement('div');

    tooltip.className = 'eg-action-floating-tooltip';
    tooltip.setAttribute('role', 'tooltip');
    document.body.appendChild(tooltip);

    const hideTooltip = () => {
        if (activeTrigger) {
            if (originalTitle) {
                activeTrigger.setAttribute('title', originalTitle);
            }

            activeTrigger = null;
            originalTitle = '';
        }

        tooltip.classList.remove('is-visible', 'is-above');
    };

    const positionTooltip = () => {
        if (!activeTrigger) {
            return;
        }

        const rect = activeTrigger.getBoundingClientRect();
        const tooltipRect = tooltip.getBoundingClientRect();
        const viewportPadding = 8;
        const gap = 10;
        let left = rect.left + rect.width / 2;
        let top = rect.bottom + gap;
        let isAbove = false;

        if (top + tooltipRect.height + viewportPadding > window.innerHeight) {
            top = rect.top - tooltipRect.height - gap;
            isAbove = true;
        }

        const halfWidth = tooltipRect.width / 2;
        left = Math.max(viewportPadding + halfWidth, Math.min(window.innerWidth - viewportPadding - halfWidth, left));
        top = Math.max(viewportPadding, top);

        tooltip.classList.toggle('is-above', isAbove);
        tooltip.style.left = `${left}px`;
        tooltip.style.top = `${top}px`;
    };

    const showTooltip = (trigger) => {
        const label = trigger.dataset.label;

        if (!label) {
            return;
        }

        activeTrigger = trigger;
        originalTitle = trigger.getAttribute('title') || '';

        if (originalTitle) {
            trigger.removeAttribute('title');
        }

        tooltip.textContent = label;
        tooltip.classList.remove('is-above');
        tooltip.classList.add('is-visible');
        positionTooltip();
    };

    document.addEventListener('pointerover', (event) => {
        const trigger = event.target.closest('.eg-action-tooltip[data-label]');

        if (!trigger || trigger === activeTrigger) {
            return;
        }

        showTooltip(trigger);
    });

    document.addEventListener('pointerout', (event) => {
        if (!activeTrigger || activeTrigger.contains(event.relatedTarget)) {
            return;
        }

        hideTooltip();
    });

    document.addEventListener('focusin', (event) => {
        const trigger = event.target.closest('.eg-action-tooltip[data-label]');

        if (trigger) {
            showTooltip(trigger);
        }
    });

    document.addEventListener('focusout', hideTooltip);
    window.addEventListener('scroll', positionTooltip, true);
    window.addEventListener('resize', positionTooltip);
});
