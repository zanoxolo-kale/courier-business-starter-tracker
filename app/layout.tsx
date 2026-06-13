import './globals.css';import type {Metadata} from 'next';import {Sidebar} from '@/components/sidebar';
export const metadata:Metadata={title:'Courier Business Starter Tracker',description:'South African courier and ride-hailing startup readiness tracker'};
export default function RootLayout({children}:{children:React.ReactNode}){return <html lang="en"><body><div className="min-h-screen lg:flex"><Sidebar/><main className="flex-1 p-4 lg:p-8">{children}</main></div></body></html>}
