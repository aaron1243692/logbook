import { defineConfig, loadEnv } from 'vite';
import laravel from 'laravel-vite-plugin';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig(({ mode }) => {
    const env = loadEnv(mode, process.cwd(), '');
    const devServerHost = env.VITE_DEV_SERVER_HOST || 'localhost';

    return {
        plugins: [
            laravel({
                input: ['resources/css/app.css', 'resources/js/app.js'],
                refresh: true,
            }),
            tailwindcss(),
        ],
        server: {
            host: '0.0.0.0',
            port: 5173,
            strictPort: true,
            cors: {
                origin: [
                    env.APP_URL || 'http://localhost:8000',
                    /^http:\/\/localhost(?::\d+)?$/,
                    /^http:\/\/127\.0\.0\.1(?::\d+)?$/,
                    /^http:\/\/192\.168\.\d+\.\d+(?::\d+)?$/,
                ],
            },
            hmr: {
                host: devServerHost,
            },
            watch: {
                ignored: ['**/storage/framework/views/**'],
            },
        },
    };
});
