import { CheckboxInput, FeatureToggle } from '../../base';

export const obscurity_examine_pref: FeatureToggle = {
  name: 'Obscure examine panel',
  category: 'GAMEPLAY',
  description: 'Toggles whether your examine panel is hidden when unknown.',
  component: CheckboxInput,
};

export const manifest_preview: FeatureToggle = {
  name: 'Visible on manifest preview',
  category: 'GAMEPLAY',
  description: 'Toggles whether your readied job shows in the pre-game lobby.',
  component: CheckboxInput,
};
