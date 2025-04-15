import { ByondUi } from 'tgui-core/components';

export const CharacterPreview = (props: { height: string; id: string }) => {
  return (
    <ByondUi
      width="226px"
      height={props.height}
      ml="2px"
      mr="4px"
      params={{
        id: props.id,
        type: 'map',
      }}
    />
  );
};
