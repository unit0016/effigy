import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Stack } from 'tgui-core/components';
import { exhaustiveCheck } from 'tgui-core/exhaustive';

import { SideDropdown } from '../../../effigy/SideDropdown';
import { PageButton } from '../components/PageButton';
import { PreferencesMenuData } from '../types';
import { AntagsPage } from './AntagsPage';
import { JobsPage } from './JobsPage';
import { LoadoutPage } from './loadout';
import { MainPage } from './MainPage';
import { QuirksPage } from './QuirksPage';
import { SpeciesPage } from './SpeciesPage';

enum Page {
  Antags,
  Main,
  Jobs,
  Species,
  Quirks,
  Loadout,
}

type ProfileProps = {
  activeSlot: number;
  onClick: (index: number) => void;
  profiles: (string | null)[];
};

function CharacterProfiles(props: ProfileProps) {
  const { activeSlot, onClick, profiles } = props;

  return (
    <Stack align="center" justify="left">
      <Stack.Item width="336px">
        <SideDropdown
          width="100%"
          selected={profiles[activeSlot]}
          options={profiles.map((profile, slot) => ({
            value: slot,
            displayText: profile ?? 'New Character',
          }))}
          onSelected={(slot) => {
            onClick(slot);
          }}
        />
      </Stack.Item>
    </Stack>
  );
}

export function CharacterPreferenceWindow(props) {
  const { act, data } = useBackend<PreferencesMenuData>();

  const [currentPage, setCurrentPage] = useState(Page.Main);

  let pageContents;

  switch (currentPage) {
    case Page.Antags:
      pageContents = <AntagsPage />;
      break;
    case Page.Jobs:
      pageContents = <JobsPage />;
      break;
    case Page.Main:
      pageContents = (
        <MainPage openSpecies={() => setCurrentPage(Page.Species)} />
      );

      break;
    case Page.Species:
      pageContents = (
        <SpeciesPage closeSpecies={() => setCurrentPage(Page.Main)} />
      );

      break;
    case Page.Quirks:
      pageContents = <QuirksPage />;
      break;

    case Page.Loadout:
      pageContents = <LoadoutPage />;
      break;

    default:
      exhaustiveCheck(currentPage);
  }

  return (
    <Stack vertical fill>
      <Stack.Item>
        <Stack fill ml="5px" mr="10px">
          <Stack.Item width="224px" fontSize="14px">
            <CharacterProfiles
              activeSlot={data.active_slot - 1}
              onClick={(slot) => {
                act('change_slot', {
                  slot: slot + 1,
                });
              }}
              profiles={data.character_profiles}
            />
          </Stack.Item>
          <Stack.Item grow={1} ml="10px">
            <PageButton
              currentPage={currentPage}
              page={Page.Main}
              setPage={setCurrentPage}
              otherActivePages={[Page.Species]}
            >
              Character
            </PageButton>
          </Stack.Item>

          <Stack.Item grow ml="10px">
            <PageButton
              currentPage={currentPage}
              page={Page.Loadout}
              setPage={setCurrentPage}
            >
              Loadout
            </PageButton>
          </Stack.Item>

          <Stack.Item grow={1} ml="10px">
            <PageButton
              currentPage={currentPage}
              page={Page.Jobs}
              setPage={setCurrentPage}
            >
              {/*
                    Fun fact: This isn't "Jobs" so that it intentionally
                    catches your eyes, because it's really important!
                  */}
              Occupations
            </PageButton>
          </Stack.Item>

          <Stack.Item grow={1} ml="10px">
            <PageButton
              currentPage={currentPage}
              page={Page.Antags}
              setPage={setCurrentPage}
            >
              Antagonists
            </PageButton>
          </Stack.Item>

          <Stack.Item grow={1} ml="10px">
            <PageButton
              currentPage={currentPage}
              page={Page.Quirks}
              setPage={setCurrentPage}
            >
              Quirks
            </PageButton>
          </Stack.Item>
        </Stack>
      </Stack.Item>

      <Stack.Item mt="10px" ml="8px">
        {pageContents}
      </Stack.Item>
    </Stack>
  );
}
