import { CheckboxInput, FeatureToggle } from '../../base';

export const lobby_cam_pre: FeatureToggle = {
  name: 'Lobby Eye',
  category: 'GAMEPLAY',
  description:
    'Toggles if you want to view a preview of the station or lobby art pregame.',
  component: CheckboxInput,
};
