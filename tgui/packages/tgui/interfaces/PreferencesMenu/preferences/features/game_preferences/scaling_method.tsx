import { createDropdownInput, Feature } from '../base';

export const scaling_method: Feature<string> = {
  name: 'Point Sampling', // EffigyEdit Change
  category: 'UI',
  component: createDropdownInput({
    /* EffigyEdit Change
    blur: 'Bilinear',
    distort: 'Disabled',
    normal: 'Enabled',
    */
    normal: 'Enabled',
    distort: 'Disabled',
  }),
};
