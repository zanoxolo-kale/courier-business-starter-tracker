import type { Config } from 'tailwindcss';
const config: Config = {content:['./app/**/*.{ts,tsx}','./components/**/*.{ts,tsx}'],theme:{extend:{colors:{brand:{50:'#eef8ff',100:'#d9efff',500:'#0ea5e9',700:'#0369a1',900:'#0c4a6e'}}}},plugins:[]};
export default config;
