<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NEXUS | Event Horizon Protocol</title>
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
            background-color: transparent;
            color: var(--white);
            font-family: 'Rajdhani', sans-serif;
            overflow-x: hidden;
            width: 100vw;
        }

        /* --- THE UNIVERSE (CANVAS) --- */
        #canvas-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            z-index: 0;
            background: var(--bg);
        }

        /* --- HUD LAYER --- */
        .hud-layer {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            pointer-events: none;
            z-index: 100;
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
        }

        .brand span { color: var(--primary); }

        .status-block {
            text-align: right;
            font-size: 0.8rem;
            color: var(--silver);
            line-height: 1.5;
            border-right: 2px solid var(--primary);
            padding-right: 15px;
        }

        .hud-bottom {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
        }

        .coords {
            font-family: monospace;
            color: var(--primary);
            font-size: 0.8rem;
        }

        .hud-links {
            pointer-events: auto;
            display: flex;
            gap: 20px;
        }

        /* --- UPDATED ENGAGING BUTTONS --- */
        .hud-link {
            position: relative;
            padding: 12px 35px;
            color: var(--white);
            text-decoration: none;
            font-family: 'Orbitron', sans-serif; /* Tech font */
            font-weight: 700;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.4s cubic-bezier(0.23, 1, 0.32, 1);
            /* Sci-fi chamfered edges */
            clip-path: polygon(12px 0, 100% 0, 100% calc(100% - 12px), calc(100% - 12px) 100%, 0 100%, 0 12px);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            backdrop-filter: blur(5px);
        }

        /* Scanline effect on hover */
        .hud-link::after {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: 0.6s;
            z-index: 1;
        }

        .hud-link:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: var(--white);
            box-shadow: 0 0 20px rgba(255, 255, 255, 0.3);
            text-shadow: 0 0 10px rgba(255, 255, 255, 0.8);
            transform: translateY(-2px);
        }

        .hud-link:hover::after {
            left: 100%;
        }

        /* Active/Register Button - Neon Pink */
        .hud-link.active {
            border-color: var(--primary);
            color: var(--primary);
            box-shadow: 0 0 15px rgba(255, 0, 110, 0.2);
        }

        .hud-link.active:hover {
            background: var(--primary);
            color: var(--white);
            box-shadow: 0 0 30px var(--primary);
            text-shadow: none;
        }

        /* --- SCROLL CONTENT SECTIONS --- */
        .scroll-container {
            position: relative;
            z-index: 20;
            padding-bottom: 200px;
        }

        section {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            perspective: 1000px;
        }

        /* HERO TEXT */
        .hero-content {
            text-align: center;
            mix-blend-mode: exclusion;
        }

        h1 {
            font-family: 'Orbitron', sans-serif;
            font-size: clamp(3rem, 12vw, 9rem);
            line-height: 0.8;
            text-transform: uppercase;
            font-weight: 900;
            margin-bottom: 20px;
            letter-spacing: -2px;
            color: var(--white);
            opacity: 0;
            transform: scale(0.8);
            animation: heroIn 1.5s cubic-bezier(0.19, 1, 0.22, 1) forwards;
            animation-delay: 0.5s;
        }

        .hero-sub {
            font-size: 1.2rem;
            letter-spacing: 5px;
            color: var(--primary);
            text-transform: uppercase;
            opacity: 0;
            animation: fadeIn 1s ease forwards;
            animation-delay: 1.2s;
        }

        /* FEATURE CARDS (Glass) */
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
            max-width: 1200px;
            width: 100%;
        }

        .glass-card {
            background: rgba(11, 11, 14, 0.4);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 40px;
            transform: translateY(50px);
            opacity: 0;
            transition: all 0.6s cubic-bezier(0.19, 1, 0.22, 1);
            position: relative;
            overflow: hidden;
        }

        .glass-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 2px; height: 100%;
            background: var(--primary);
            opacity: 0.5;
        }

        .glass-card:hover {
            border-color: var(--primary);
            background: rgba(49, 13, 61, 0.3);
            transform: translateY(0) scale(1.02);
            box-shadow: 0 0 30px rgba(255, 0, 110, 0.2);
        }

        .glass-card h3 {
            font-family: 'Orbitron', sans-serif;
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: var(--white);
        }

        .glass-card p {
            color: var(--silver);
            line-height: 1.6;
        }

        .glass-card i {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 20px;
            display: inline-block;
        }

        /* CTA SECTION */
        .cta-wrapper {
            text-align: center;
        }

        .cyber-btn {
            position: relative;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            font-family: 'Orbitron', sans-serif;
            font-weight: 700;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 3px;
            color: var(--white);
            background: transparent;
            border: 1px solid var(--primary);
            padding: 25px 60px;
            font-size: 1.2rem;
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
            box-shadow: 0 0 50px var(--primary);
            border-color: transparent;
        }

        /* --- UTILITY ANIMATIONS --- */
        .visible {
            opacity: 1;
            transform: translateY(0);
        }

        @keyframes heroIn {
            to { opacity: 1; transform: scale(1); }
        }

        @keyframes fadeIn {
            to { opacity: 1; }
        }

        /* Scroll indicator */
        .scroll-hint {
            position: absolute;
            bottom: 40px;
            left: 50%;
            transform: translateX(-50%);
            color: var(--white);
            font-size: 2rem;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translate(-50%, 0); opacity: 0.5; }
            50% { transform: translate(-50%, 10px); opacity: 1; }
        }

        /* CUSTOM SCROLLBAR */
        ::-webkit-scrollbar { width: 0px; }

    </style>
</head>

<body>

<!-- 3D CONTAINER -->
<div id="canvas-container"></div>

<!-- HEADS UP DISPLAY (FIXED) -->
<div class="hud-layer">
    <div class="hud-top">
        <div class="brand">
            <i class="ri-shining-2-fill"></i> NEXUS<span>CORE</span>
        </div>
        <div class="status-block">
            SYSTEM: ONLINE<br>
            FPS: <span id="fps-counter">60</span><br>
            SECURE CONN
        </div>
    </div>
    <div class="hud-bottom">
        <div class="coords" id="coords">
            X: 000.00 Y: 000.00 Z: 000.00
        </div>
        <div class="hud-links">
            <a href="jsp/login.jsp" class="hud-link">LOGIN</a>
            <a href="jsp/signup.jsp" class="hud-link active">REGISTER</a>
        </div>
    </div>
</div>

<!-- SCROLLABLE CONTENT -->
<div class="scroll-container">

    <!-- HERO -->
    <section id="s-hero">
        <div class="hero-content">
            <div class="hero-sub">Welcome to the machine</div>
            <h1>Infinite<br>Knowledge</h1>
            <div class="scroll-hint">
                <i class="ri-arrow-down-double-line"></i>
            </div>
        </div>
    </section>

    <!-- FEATURES -->
    <section id="s-features">
        <div class="feature-grid">
            <div class="glass-card observer-target">
                <i class="ri-database-2-fill"></i>
                <h3>Hyper-Archive</h3>
                <p>Access 100 Petabytes of academic, literary, and scientific data stored in our decentralized neural clusters.</p>
            </div>
            <div class="glass-card observer-target" style="transition-delay: 0.2s;">
                <i class="ri-speed-mini-fill"></i>
                <h3>Warp Sync</h3>
                <p>Information travels faster than light. Instantaneously download knowledge directly to your personal node.</p>
            </div>
            <div class="glass-card observer-target" style="transition-delay: 0.4s;">
                <i class="ri-brain-fill"></i>
                <h3>Cognitive AI</h3>
                <p>Our Core AI predicts your learning trajectory, curating the perfect path for your intellectual evolution.</p>
            </div>
        </div>
    </section>

    <!-- CTA -->
    <section id="s-cta">
        <div class="cta-wrapper observer-target">
            <h2 style="font-family: 'Orbitron'; font-size: 3rem; margin-bottom: 40px; text-transform: uppercase;">
                Ready to <span style="color: var(--primary);">Ascend?</span>
            </h2>
            <a href="jsp/signup.jsp" class="cyber-btn">
                Initialize Sequence
            </a>
        </div>
    </section>

</div>

<!-- LOGIC -->
<script>
    // --- THREE.JS SETUP ---
    const container = document.getElementById('canvas-container');
    const scene = new THREE.Scene();
    // Fog for depth (Deep Purple Glow)
    scene.fog = new THREE.FogExp2(0x0B0B0E, 0.002);

    const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 2000);
    const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });

    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setPixelRatio(window.devicePixelRatio);
    container.appendChild(renderer.domElement);

    // --- TEXTURE GENERATION (Fix for Squares) ---
    // Programmatically creates a soft circle texture so we don't rely on external images
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
        const texture = new THREE.CanvasTexture(canvas);
        return texture;
    }

    const particleTexture = getTexture();

    // --- PARTICLES (THE GALAXY) ---

    const createStarField = (count, color, size, spread) => {
        const geometry = new THREE.BufferGeometry();
        const vertices = [];

        for (let i = 0; i < count; i++) {
            const x = (Math.random() - 0.5) * spread;
            const y = (Math.random() - 0.5) * spread;
            const z = (Math.random() - 0.5) * spread;
            vertices.push(x, y, z);
        }

        geometry.setAttribute('position', new THREE.Float32BufferAttribute(vertices, 3));

        const material = new THREE.PointsMaterial({
            color: color,
            size: size,
            map: particleTexture, // Applied texture
            transparent: true,
            opacity: 0.8,
            sizeAttenuation: true,
            depthWrite: false
        });

        return new THREE.Points(geometry, material);
    };

    // 1. Background Dust (Silver/White)
    const stars = createStarField(5000, 0xFFFFFF, 0.8, 2000);
    scene.add(stars);

    // 2. The Core Nexus (Neon Pink) - A spiral shape
    const coreGeometry = new THREE.BufferGeometry();
    const coreVertices = [];
    const coreCount = 4000;

    for(let i=0; i<coreCount; i++) {
        const angle = i * 0.02;
        const radius = 5 + (i * 0.1);
        const x = Math.cos(angle) * radius + (Math.random() - 0.5) * 5;
        const y = (Math.random() - 0.5) * 40;
        const z = Math.sin(angle) * radius + (Math.random() - 0.5) * 5;
        coreVertices.push(x, y, z);
    }

    coreGeometry.setAttribute('position', new THREE.Float32BufferAttribute(coreVertices, 3));
    const coreMaterial = new THREE.PointsMaterial({
        color: 0xFF006E, // PRIMARY COLOR
        size: 1.5,
        map: particleTexture, // Applied texture
        transparent: true,
        opacity: 0.9,
        blending: THREE.AdditiveBlending,
        depthWrite: false
    });
    const nexusCore = new THREE.Points(coreGeometry, coreMaterial);
    scene.add(nexusCore);

    // 3. Ambient Glow Orbs (Purple)
    const glowGeometry = new THREE.BufferGeometry();
    const glowVertices = [];
    for(let i=0; i<20; i++) {
        glowVertices.push(
            (Math.random()-0.5)*800,
            (Math.random()-0.5)*800,
            (Math.random()-0.5)*800
        );
    }
    glowGeometry.setAttribute('position', new THREE.Float32BufferAttribute(glowVertices, 3));
    const glowMaterial = new THREE.PointsMaterial({
        color: 0x310D3D, // AMBIENT GLOW
        size: 200,
        map: particleTexture, // Applied texture (Crucial fix for squares)
        transparent: true,
        opacity: 0.4,
        blending: THREE.AdditiveBlending,
        depthWrite: false
    });
    const glowOrbs = new THREE.Points(glowGeometry, glowMaterial);
    scene.add(glowOrbs);


    camera.position.z = 400;

    // --- ANIMATION LOOP ---
    let mouseX = 0;
    let mouseY = 0;
    let targetX = 0;
    let targetY = 0;

    let scrollY = 0;

    document.addEventListener('mousemove', (e) => {
        mouseX = (e.clientX - window.innerWidth / 2) * 0.5;
        mouseY = (e.clientY - window.innerHeight / 2) * 0.5;
    });

    window.addEventListener('scroll', () => {
        scrollY = window.scrollY;
        document.getElementById('coords').innerHTML = `X: ${mouseX.toFixed(2)} Y: ${mouseY.toFixed(2)} Z: ${scrollY.toFixed(2)}`;
    });

    const clock = new THREE.Clock();

    function animate() {
        const time = clock.getElapsedTime();

        targetX = mouseX * 0.001;
        targetY = mouseY * 0.001;

        nexusCore.rotation.y += 0.002;
        nexusCore.rotation.z += 0.001;

        const scale = 1 + Math.sin(time) * 0.05;
        nexusCore.scale.set(scale, scale, scale);

        stars.rotation.y -= 0.0005;

        const targetZ = 400 - (scrollY * 0.5);
        camera.position.z += (targetZ - camera.position.z) * 0.05;

        camera.position.x += (mouseX - camera.position.x) * 0.02;
        camera.position.y += (-mouseY - camera.position.y) * 0.02;

        camera.lookAt(scene.position);

        renderer.render(scene, camera);
        requestAnimationFrame(animate);

        if (Math.random() > 0.95) {
            document.getElementById('fps-counter').innerText = Math.round(1000 / (performance.now() % 100 + 10));
        }
    }

    animate();

    // --- OBSERVER FOR SCROLL REVEALS ---
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.observer-target').forEach(el => observer.observe(el));

    // --- RESIZE HANDLER ---
    window.addEventListener('resize', () => {
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();
        renderer.setSize(window.innerWidth, window.innerHeight);
    });

</script>
</body>

</html>