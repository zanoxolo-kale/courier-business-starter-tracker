import { z } from 'zod';
export const checklistSchema=z.object({title:z.string().min(2),status:z.enum(['Not Started','In Progress','Completed','Blocked']),priority:z.enum(['Low','Medium','High']),notes:z.string().optional()});
export const documentSchema=z.object({documentName:z.string().min(2),status:z.enum(['Missing','In Progress','Ready','Uploaded','Rejected','Expired']),notes:z.string().optional()});
export type ChecklistForm=z.infer<typeof checklistSchema>;export type DocumentForm=z.infer<typeof documentSchema>;
