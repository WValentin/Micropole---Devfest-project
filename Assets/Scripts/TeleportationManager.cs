using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.XR.Interaction.Toolkit;

public class TeleportationManager : MonoBehaviour
{
    [SerializeField]
    private InputActionAsset actionAsset;

    [SerializeField]
    private XRRayInteractor rayInteractorL;
    [SerializeField]
    private XRRayInteractor rayInteractorR;

    [SerializeField]
    private TeleportationProvider provider;


    private InputAction _thumbstickR;
    private InputAction _thumbstickL;

    private bool _isActive;

    // Start is called before the first frame update
    void Start()
    {
        var activateL = actionAsset.FindActionMap("XRI LeftHand Locomotion").FindAction("Teleport Mode Activate");
        var activateR = actionAsset.FindActionMap("XRI RightHand Locomotion").FindAction("Teleport Mode Activate");
        activateL.Enable();
        activateR.Enable();
        activateL.performed += OnTeleportActivate;
        activateR.performed += OnTeleportActivate;

        var cancelL = actionAsset.FindActionMap("XRI LeftHand Locomotion").FindAction("Teleport Mode Cancel");
        var cancelR = actionAsset.FindActionMap("XRI RightHand Locomotion").FindAction("Teleport Mode Cancel");
        cancelL.Enable();
        cancelR.Enable();
        cancelL.performed += OnTeleportCancel;
        cancelR.performed += OnTeleportCancel;

        _thumbstickL = actionAsset.FindActionMap("XRI LeftHand Locomotion").FindAction("Move");
        _thumbstickR = actionAsset.FindActionMap("XRI RightHand Locomotion").FindAction("Move");
        _thumbstickL.Enable();
        _thumbstickR.Enable();
    }

    // Update is called once per frame
    void Update()
    {
        if (!_isActive)
            return;

        if (_thumbstickL.triggered)
            return;
        if (_thumbstickR.triggered)
            return;

        if (!rayInteractorL.TryGetCurrent3DRaycastHit(out RaycastHit hit1))
        {
            rayInteractorL.enabled = false;
            _isActive = false;
            return;
        }
        if (!rayInteractorR.TryGetCurrent3DRaycastHit(out RaycastHit hit2))
        {
            rayInteractorR.enabled = false;
            _isActive = false;
            return;
        }

        TeleportRequest request1 = new TeleportRequest()
        {
            destinationPosition = hit1.point,
        };

        TeleportRequest request2 = new TeleportRequest()
        {
            destinationPosition = hit2.point,
        };

        provider.QueueTeleportRequest(request1);
        provider.QueueTeleportRequest(request2);

    }

    private void OnTeleportActivate(InputAction.CallbackContext context)
    {
        rayInteractorL.lineType = XRRayInteractor.LineType.ProjectileCurve;
        rayInteractorR.lineType = XRRayInteractor.LineType.ProjectileCurve;

        _isActive = true;
    }

    private void OnTeleportCancel(InputAction.CallbackContext context)
    {
        rayInteractorL.lineType = XRRayInteractor.LineType.StraightLine;
        rayInteractorR.lineType = XRRayInteractor.LineType.StraightLine;
        _isActive = false;
    }
}
