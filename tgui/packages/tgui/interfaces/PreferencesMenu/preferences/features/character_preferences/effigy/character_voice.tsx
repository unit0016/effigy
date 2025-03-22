import { Button, Stack } from 'tgui-core/components';

import {
  CheckboxInput,
  FeatureChoiced,
  FeatureChoicedServerData,
  FeatureNumeric,
  FeatureSliderInput,
  FeatureToggle,
  FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

const FeatureBlooperDropdownInput = (
  props: FeatureValueProps<string, string, FeatureChoicedServerData>,
) => {
  return (
    <Stack>
      <Stack.Item grow>
        <FeatureDropdownInput {...props} />
      </Stack.Item>
      <Stack.Item>
        <Button
          onClick={() => {
            props.act('play_blooper');
          }}
          icon="play"
          width="100%"
          height="100%"
        />
      </Stack.Item>
    </Stack>
  );
};

export const blooper_speech: FeatureChoiced = {
  name: 'Character Voice',
  component: FeatureBlooperDropdownInput,
};

export const blooper_speech_speed: FeatureNumeric = {
  name: 'Character Voice Speed',
  description: 'Lower number, faster speed. Higher number, slower voice.',
  component: FeatureSliderInput,
};

export const blooper_speech_pitch: FeatureNumeric = {
  name: 'Character Voice Pitch',
  description: 'Lower number, deeper pitch. Higher number, higher pitch.',
  component: FeatureSliderInput,
};

export const blooper_pitch_range: FeatureNumeric = {
  name: 'Character Voice Range',
  description: 'Lower number, less range. Higher number, more range.',
  component: FeatureSliderInput,
};

export const hear_sound_blooper: FeatureToggle = {
  name: 'Enable vocal bloopers',
  category: 'SOUND',
  component: CheckboxInput,
};

export const character_laugh: FeatureChoiced = {
  name: 'Character Laugh',
  component: FeatureDropdownInput,
};

export const character_scream: FeatureChoiced = {
  name: 'Character Scream',
  component: FeatureDropdownInput,
};
