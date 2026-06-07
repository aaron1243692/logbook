// import { defineConfig } from 'vite';
// import laravel from 'laravel-vite-plugin';
// import tailwindcss from '@tailwindcss/vite';

// export default defineConfig({
//     plugins: [
//         laravel({
//             input: ['resources/css/app.css', 'resources/js/app.js'],
//             refresh: true,
//         }),
//         tailwindcss(),
//     ],
//     server: {
//         host: '127.0.0.1',
//         cors: {
//             origin: [
//                 'http://192.168.92.140:8000',
//                 /^http:\/\/localhost(?::\d+)?$/,
//                 /^http:\/\/127\.0\.0\.1(?::\d+)?$/,
//             ],
//         },
//         hmr: {
//             host: '192.168.92.140',
//         },
//         watch: {
//             ignored: ['**/storage/framework/views/**'],
//         },
//     },
// });


import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
    plugins: [
        laravel({
            input: [
                'resources/css/app.css',
                'resources/js/app.js',
            ],
            refresh: true,
        }),
        tailwindcss(),
    ],

    server: {
        host: '0.0.0.0',
        port: 5173,

        hmr: {
            host: '192.168.92.140', // Your PC's IP
            port: 5173,
        },

        watch: {
            ignored: ['**/storage/framework/views/**'],
        },
    },
});
