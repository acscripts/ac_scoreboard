type Footer = {
  serverId: number;
  playerCount: number;
  maxPlayers: number;
};

type Group = {
  label: string;
  count: number;
};

type Player = {
  name?: string;
  id?: string;
};

type StatusIndicator = {
  label: string;
  icon: string;
  state: boolean;
};

type SheetData = {
  footer?: Footer;
  groups?: Group[];
  players?: Player[];
  statusIndicators?: StatusIndicator[];
};

export type { SheetData as default };
