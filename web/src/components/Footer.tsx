import { useContext } from "react";
import { LocaleContext } from "./Scoreboard";
import {
  Text,
  Tag,
  TagLeftIcon,
  HStack,
  Tooltip,
  useClipboard,
} from "@chakra-ui/react";
import { FaUserAlt, FaUserFriends } from "react-icons/fa";

interface Props {
  playerCount: number;
  maxPlayers: number;
  serverId: number;
}

const Footer: React.FC<Props> = (props: Props) => {
  const locales = useContext(LocaleContext);
  const { hasCopied, onCopy } = useClipboard(props.serverId.toString(), 2500);

  return (
    <HStack>
      <Tooltip closeOnClick={false} label={locales["ui_player_count"]}>
        <Tag>
          <TagLeftIcon as={FaUserFriends} boxSize={4} />
          <Text>
            {props.playerCount} / {props.maxPlayers}
          </Text>
        </Tag>
      </Tooltip>
      <Tooltip
        closeOnClick={false}
        label={hasCopied ? locales["ui_copied"] : locales["ui_your_id"]}
      >
        <Tag onClick={onCopy} cursor="pointer">
          <TagLeftIcon as={FaUserAlt} boxSize={3} />
          <Text>{props.serverId}</Text>
        </Tag>
      </Tooltip>
    </HStack>
  );
};

export default Footer;
