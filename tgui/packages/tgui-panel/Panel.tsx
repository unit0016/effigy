/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import { Pane } from 'tgui/layouts';
import { Button, Section, Stack } from 'tgui-core/components';

import { NowPlayingWidget, useAudio } from './audio';
import { ChatPanel, ChatTabs } from './chat';
import { useGame } from './game';
import { Notifications } from './Notifications';
import { PingIndicator } from './ping';
import { ReconnectButton } from './reconnect';
import { SettingsPanel, useSettings } from './settings';

export const Panel = (props) => {
  const audio = useAudio();
  const settings = useSettings();
  const game = useGame();
  if (process.env.NODE_ENV !== 'production') {
    const { useDebug, KitchenSink } = require('tgui/debug');
    const debug = useDebug();
    if (debug.kitchenSink) {
      return <KitchenSink panel />;
    }
  }

  return (
    <Pane theme={settings.theme}>
      <Stack fill vertical>
        <Stack.Item>
          <Section fitted>
            {/* EffigyEdit Change - TGUI - change align to top */}
            <Stack mr={1} mb={-1} align="top">
              <Stack.Item grow overflowX="auto">
                <ChatTabs />
              </Stack.Item>
              {/* EffigyEdit Change - TGUI - add mt=0.7 */}
              <Stack.Item mt={0.7}>
                <PingIndicator />
              </Stack.Item>
              {/* EffigyEdit Change - TGUI - add mt=0.7 */}
              <Stack.Item mt={0.7}>
                <Button
                  color="grey"
                  selected={audio.visible}
                  icon="music"
                  tooltip="Music player"
                  tooltipPosition="bottom-start"
                  onClick={() => audio.toggle()}
                />
              </Stack.Item>
              {/* EffigyEdit Change - TGUI - add mt=0.7 */}
              <Stack.Item mt={0.7}>
                <Button
                  icon={settings.visible ? 'times' : 'cog'}
                  selected={settings.visible}
                  tooltip={
                    settings.visible ? 'Close settings' : 'Open settings'
                  }
                  tooltipPosition="bottom-start"
                  onClick={() => settings.toggle()}
                />
              </Stack.Item>
            </Stack>
          </Section>
        </Stack.Item>
        {audio.visible && (
          <Stack.Item>
            <Section>
              <NowPlayingWidget />
            </Section>
          </Stack.Item>
        )}
        {settings.visible && (
          <Stack.Item>
            <SettingsPanel />
          </Stack.Item>
        )}
        <Stack.Item grow>
          <Section fill fitted position="relative">
            <Pane.Content scrollable>
              <ChatPanel lineHeight={settings.lineHeight} />
            </Pane.Content>
            <Notifications>
              {game.connectionLostAt && (
                /* EffigyEdit Change - TGUI
                <Notifications.Item rightSlot={<ReconnectButton />}>
                  You are either AFK, experiencing lag or the connection has
                  closed.
                </Notifications.Item>
                */
                <Notifications.Item rightSlot={<ReconnectButton />}>
                  Connectivity issues:
                  <br />
                  Server lagging / connection closed.
                </Notifications.Item>
              )}
              {game.roundRestartedAt && (
                /* // EffigyEdit Change - TGUI
                <Notifications.Item>
                  The connection has been closed because the server is
                  restarting. Please wait while you automatically reconnect.
                </Notifications.Item>
                */
                <Notifications.Item>
                  Server restarting:
                  <br />
                  Please wait...
                </Notifications.Item>
              )}
            </Notifications>
          </Section>
        </Stack.Item>
      </Stack>
    </Pane>
  );
};
