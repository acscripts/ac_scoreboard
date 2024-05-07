import { type ClassValue, clsx } from 'clsx';
import { twMerge } from 'tailwind-merge';

export const isEnvBrowser = (): boolean => !(window as any).invokeNative;

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
