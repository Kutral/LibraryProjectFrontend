<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - The Knowledge Nexus</title>
    <!-- Remix Icons -->
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.1.0/fonts/remixicon.css" rel="stylesheet" />
    <!-- Three.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Rajdhani:wght@300;500;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #FF006E; /* Neon Pink */
            --bg: #0B0B0E; /* Deep Charcoal */
            --glow: #310D3D; /* Deep Purple */
            --white: #FFFFFF;
            --silver: #B0B0B0;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: var(--bg);
            color: var(--white);
            font-family: 'Rajdhani', sans-serif;
            overflow: hidden;
            width: 100vw;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* --- THE UNIVERSE (CANVAS) --- */
        #canvas-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            z-index: 1;
        }

        /* --- HUD LAYER --- */
        .hud-layer {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            pointer-events: none;
            z-index: 10;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .hud-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .brand {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.5rem;
            letter-spacing: 4px;
            text-transform: uppercase;
            color: var(--white);
            text-shadow: 0 0 20px var(--glow);
            pointer-events: auto;
            text-decoration: none;
        }

        .brand span { color: var(--primary); }

        /* --- AUTH CARD --- */
        .auth-wrapper {
            position: relative;
            z-index: 20;
            width: 100%;
            max-width: 440px;
            perspective: 1000px;
        }

        .glass-card {
            background: rgba(11, 11, 14, 0.7);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 48px;
            border-radius: 4px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0,0,0,0.5);
            animation: cardIn 0.8s cubic-bezier(0.19, 1, 0.22, 1) forwards;
            opacity: 0;
            transform: translateY(30px);
        }

        @keyframes cardIn {
            to { opacity: 1; transform: translateY(0); }
        }

        .glass-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 2px; height: 100%;
            background: var(--primary);
            box-shadow: 0 0 15px var(--primary);
        }

        h1 {
            font-family: 'Orbitron', sans-serif;
            font-size: 2.2rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 8px;
            color: var(--white);
        }

        p {
            color: var(--silver);
            font-size: 1rem;
            margin-bottom: 32px;
            letter-spacing: 1px;
        }

        /* --- FORM ELEMENTS --- */
        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            font-family: 'Orbitron', sans-serif;
            font-size: 0.8rem;
            letter-spacing: 2px;
            color: var(--primary);
            margin-bottom: 8px;
            text-transform: uppercase;
        }

        .form-group input {
            width: 100%;
            padding: 12px 16px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: var(--white);
            font-family: 'Rajdhani', sans-serif;
            font-size: 1.1rem;
            transition: 0.3s;
            outline: none;
        }

        .form-group input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 15px rgba(255, 0, 110, 0.2);
            background: rgba(255, 255, 255, 0.1);
        }

        .cyber-btn {
            position: relative;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 3px;
            color: var(--white);
            background: transparent;
            border: 1px solid var(--primary);
            padding: 16px;
            width: 100%;
            font-size: 1rem;
            cursor: pointer;
            transition: 0.3s;
            overflow: hidden;
            z-index: 1;
        }

        .cyber-btn::before {
            content: '';
            position: absolute;
            top: 0; left: -100%;
            width: 100%; height: 100%;
            background: var(--primary);
            transition: 0.4s cubic-bezier(0.19, 1, 0.22, 1);
            z-index: -1;
        }

        .cyber-btn:hover::before {
            left: 0;
        }

        .cyber-btn:hover {
            box-shadow: 0 0 30px rgba(255, 0, 110, 0.4);
            border-color: transparent;
        }

        .auth-link {
            display: block;
            margin-top: 24px;
            text-align: center;
            color: var(--silver);
            text-decoration: none;
            font-size: 0.9rem;
            letter-spacing: 1px;
            transition: 0.3s;
        }

        .auth-link:hover {
            color: var(--primary);
            text-shadow: 0 0 10px rgba(255, 0, 110, 0.5);
        }

        .alert {
            padding: 12px;
            margin-bottom: 24px;
            border: 1px solid rgba(255, 59, 48, 0.5);
            background: rgba(255, 59, 48, 0.1);
            color: #ff453a;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

    </style>
</head>

<body>

    <!-- 3D BACKGROUND -->
    <div id="canvas-container"></div>

    <!-- HUD -->
    <div class="hud-layer">
        <div class="hud-top">
            <a href="${pageContext.request.contextPath}/" class="brand">
                <i class="ri-shining-2-fill"></i> NEXUS<span>CORE</span>
            </a>
        </div>
    </div>

    <!-- AUTH FORM -->
    <div class="auth-wrapper">
        <div class="glass-card">
            <h1>Sign Up</h1>
            <p>Join the Knowledge Nexus community.</p>

            <% String error=(String) request.getAttribute("errorMessage"); if (error !=null) { %>
                <div class="alert">
                    <i class="ri-error-warning-line"></i>
                    <%= error %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/signup" method="post">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required autocomplete="off">
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required autocomplete="off">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="cyber-btn">
                    Sign Up
                </button>
            </form>

            <a href="login.jsp" class="auth-link">
                Already registered? <span style="color: var(--white); font-weight: 700;">Sign In</span>
            </a>
        </div>
    </div>

    <script>
        // --- THREE.JS SETUP ---
        const container = document.getElementById('canvas-container');
        const scene = new THREE.Scene();
        scene.fog = new THREE.FogExp2(0x0B0B0E, 0.002);

        const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 2000);
        const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });

        renderer.setSize(window.innerWidth, window.innerHeight);
        renderer.setPixelRatio(window.devicePixelRatio);
        container.appendChild(renderer.domElement);

        function getTexture() {
            const canvas = document.createElement('canvas');
            canvas.width = 32;
            canvas.height = 32;
            const context = canvas.getContext('2d');
            const gradient = context.createRadialGradient(16, 16, 0, 16, 16, 16);
            gradient.addColorStop(0, 'rgba(255,255,255,1)');
            gradient.addColorStop(1, 'rgba(255,255,255,0)');
            context.fillStyle = gradient;
            context.fillRect(0, 0, 32, 32);
            return new THREE.CanvasTexture(canvas);
        }

        const particleTexture = getTexture();

        const createStarField = (count, color, size, spread) => {
            const geometry = new THREE.BufferGeometry();
            const vertices = [];
            for (let i = 0; i < count; i++) {
                vertices.push((Math.random() - 0.5) * spread, (Math.random() - 0.5) * spread, (Math.random() - 0.5) * spread);
            }
            geometry.setAttribute('position', new THREE.Float32BufferAttribute(vertices, 3));
            return new THREE.Points(geometry, new THREE.PointsMaterial({
                color: color, size: size, map: particleTexture, transparent: true, opacity: 0.8, depthWrite: false
            }));
        };

        const stars = createStarField(5000, 0xFFFFFF, 0.8, 2000);
        scene.add(stars);

        const coreGeometry = new THREE.BufferGeometry();
        const coreVertices = [];
        for(let i=0; i<4000; i++) {
            const angle = i * 0.02;
            const radius = 5 + (i * 0.1);
            coreVertices.push(Math.cos(angle) * radius + (Math.random() - 0.5) * 5, (Math.random() - 0.5) * 40, Math.sin(angle) * radius + (Math.random() - 0.5) * 5);
        }
        coreGeometry.setAttribute('position', new THREE.Float32BufferAttribute(coreVertices, 3));
        const nexusCore = new THREE.Points(coreGeometry, new THREE.PointsMaterial({
            color: 0xFF006E, size: 1.5, map: particleTexture, transparent: true, opacity: 0.9, blending: THREE.AdditiveBlending, depthWrite: false
        }));
        scene.add(nexusCore);

        camera.position.z = 400;
        let mouseX = 0, mouseY = 0;
        document.addEventListener('mousemove', (e) => {
            mouseX = (e.clientX - window.innerWidth / 2) * 0.5;
            mouseY = (e.clientY - window.innerHeight / 2) * 0.5;
        });

        const clock = new THREE.Clock();
        function animate() {
            const time = clock.getElapsedTime();
            nexusCore.rotation.y += 0.002;
            nexusCore.rotation.z += 0.001;
            const s = 1 + Math.sin(time) * 0.05;
            nexusCore.scale.set(s, s, s);
            stars.rotation.y -= 0.0005;
            camera.position.x += (mouseX - camera.position.x) * 0.02;
            camera.position.y += (-mouseY - camera.position.y) * 0.02;
            camera.lookAt(scene.position);
            renderer.render(scene, camera);
            requestAnimationFrame(animate);
        }
        animate();
        window.addEventListener('resize', () => {
            camera.aspect = window.innerWidth / window.innerHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(window.innerWidth, window.innerHeight);
        });
    </script>
</body>
</html>