import {
  FeatureChoiced,
  FeatureChoicedServerData,
  FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const head_type: FeatureChoiced = {
  name: 'Variation: Head',
  description: `
  Add a cybernetic head to your character, this option is exclusive to this species.
`,
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const chest_type: FeatureChoiced = {
  name: 'Variation: Chest',
  description: `
  Add a cybernetic chassis to your character.
`,
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const arm_r_type: FeatureChoiced = {
  name: 'Variation: Right Arm',
  description: `
  Add a cybernetic arm to your character.
`,
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const arm_l_type: FeatureChoiced = {
  name: 'Variation: Left Arm',
  description: `
  Add a cybernetic arm to your character.
`,
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const leg_r_type: FeatureChoiced = {
  name: 'Variation: Right Leg',
  description: `
  Add a cybernetic leg to your character.
`,
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const leg_l_type: FeatureChoiced = {
  name: 'Variation: Left Leg',
  description: `
  Add a cybernetic leg to your character.
`,
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};
